Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E452CDC2BB
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405341AbfJRK0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 06:26:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63590 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404321AbfJRK0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2019 06:26:23 -0400
Received: from 79.184.255.51.ipv4.supernova.orange.pl (79.184.255.51) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 678a9a468f647381; Fri, 18 Oct 2019 12:26:20 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI/PM: Use dev_printk() when possible
Date:   Fri, 18 Oct 2019 12:26:20 +0200
Message-ID: <2088720.TElhCYhjX6@kreacher>
In-Reply-To: <20191017212851.54237-1-helgaas@kernel.org>
References: <20191017212851.54237-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, October 17, 2019 11:28:49 PM CEST Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Some PM messages, e.g., "PCI PM: Device state not saved by %pS\n", had no
> indication of what device was affected.  Add pci_WARN() and use it.
> 
> Bjorn Helgaas (2):
>   PCI/PM: Use PCI dev_printk() wrappers for consistency
>   PCI/PM: Use pci_WARN() to include device information
> 
>  drivers/pci/pci-driver.c | 45 ++++++++++++++++++++--------------------
>  include/linux/pci.h      |  8 +++++++
>  2 files changed, 31 insertions(+), 22 deletions(-)
> 
> 

Good cleanups!

For both

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>




