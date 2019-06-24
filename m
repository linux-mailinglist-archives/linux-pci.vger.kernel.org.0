Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF80500BC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 06:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFXE1I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 00:27:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:45188 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbfFXE1I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 00:27:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5O4R258012844;
        Sun, 23 Jun 2019 23:27:03 -0500
Message-ID: <ed3d3e4e87b54fa4d0d8e68abeebb7be6711b82a.camel@kernel.crashing.org>
Subject: Question about call to pci_assign_unassigned_bus_resources in amdgpu
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>, linux-pci@vger.kernel.org
Date:   Mon, 24 Jun 2019 14:27:02 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christian !

While cleaning up & consolidating resource management code accross
archs I stumbled upon this call to pci_assign_unassigned_bus_resources
in amdgpu:amdgpu_device_resize_fb_bar()

Why do you need this ? My understanding is that pci_resize_resource()
will already be calling pci_reassign_bridge_resources() on the parent
bridge which should have the same effect. Or am I missing something ?

I'd like to remove that call if possible...

Cheers,
Ben.


