Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD61E3E31F4
	for <lists+linux-pci@lfdr.de>; Sat,  7 Aug 2021 00:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244574AbhHFWwu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 18:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244333AbhHFWwu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 18:52:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBC4D60EE9;
        Fri,  6 Aug 2021 22:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628290354;
        bh=8AhSzyoKMb17jPDzZIXalXwaGBTj/E65mxGB0HZtyQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cUznrRVcak9e6FGk/LLIA/DBMGgPGAwK5zdyK6P2fo471bSkkbzthlA7ECPmcmDkS
         dmIS4Uq6kV/zIJUmqMTMkzZ5LqATWpE3xhCdm/gjQjwpYYHTIGYZ3ceJ9XjFMVrgMj
         OYSh/5+DKqCOzfkrTJd0HhbHoLH3t0syVrR0/ZVcOQagJT+82JWS9ftK6QDCVBDCbl
         DwqNvHvIM6jj/WTO3TjwLgjHZni/WMJCmLLRWYJJWye6Ya9An/5zFeiWMxG06v0spI
         ZJZeBQLEDcldVw8Umpd0ASlLTJyTyxpUz1LjP30J2hsMqWB4pB9uB3Bf3rw0YvU11Z
         Y5EizCYuH+OZQ==
Date:   Fri, 6 Aug 2021 17:52:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: of: Fix handling of multi-level PCI devices
Message-ID: <20210806225232.GA1893914@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3365235394fe4e7f35694c95af95fce96da7c9bb.1628151761.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 05, 2021 at 10:28:58AM +0200, Mauro Carvalho Chehab wrote:

> 	$ dmesg|grep of_node

Adding "|cut -b16-" or so would make this more readable.  Could also
indent by two spaces instead of a tab if that would help.

> 	[    4.932405]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
> 	[    4.985916] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000
