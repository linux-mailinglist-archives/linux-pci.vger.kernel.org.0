Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7705C504D3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 10:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfFXIr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 04:47:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:36708 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfFXIr4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 04:47:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5O8lpa8023097;
        Mon, 24 Jun 2019 03:47:52 -0500
Message-ID: <ea9f770c373ad9c6a998edbd603972014e4b7fea.camel@kernel.crashing.org>
Subject: Re: Question about call to pci_assign_unassigned_bus_resources in
 amdgpu
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Mon, 24 Jun 2019 18:47:50 +1000
In-Reply-To: <71904c98-be86-2807-d5c9-4b90c7387f6f@amd.com>
References: <ed3d3e4e87b54fa4d0d8e68abeebb7be6711b82a.camel@kernel.crashing.org>
         <71904c98-be86-2807-d5c9-4b90c7387f6f@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-06-24 at 08:42 +0000, Koenig, Christian wrote:
> Then we resize the VRAM BAR by calling pci_resize_resource(). That in 
> turn tries to resize and shuffle around the parent bridge resources 
> using pci_reassign_bridge_resources().
> 
> But pci_reassign_bridge_resources() does not assign any device 
> resources, it just tries to make sure the upstream bridges have enough 
> space to fit everything in.
> 
> Independent if we succeeded or failed with handling the bridge(s) we 
> call pci_assign_unassigned_bus_resources() to re-assign the previously 
> freed up VRAM and doorbell BARs.
> 
> So yeah, this definitely necessary, or otherwise the driver would crash 
> soon after because the resources are not assigned again.

Oh, I missed that pci_reassign_bridge_resources() didn't reassign the
resources under the bridge... ugh... that code is a bloody mess.

We have 4 or 5 "assign bus resources" functions, all subtly different
for no clear reasons (the historical changelogs from Yinghai may as
well don't exist, they are basically encrypted), and in most case for
no good reasons....

Question: Do you ever need to assign anything other than that one
device though ? In my branch, I've added this typically for the case
where a single device needs to be reassigned:

+void pci_dev_assign_resources(struct pci_dev *dev)
+{
+	LIST_HEAD(head);
+
+	/* Assign non-fixed resources */
+	__dev_sort_resources(dev, &head);
+	__assign_resources_sorted(&head, NULL, NULL);
+
+	/* Assign fixed ones if any */
+	pdev_assign_fixed_resources(dev);
+}
+EXPORT_SYMBOL(pci_dev_assign_resources);

Would that work for you ?

If yes, I'll replace pci_assign_unassigned_bus_resources(). I'd like to
eventually kill it..

Cheers,
Ben.


