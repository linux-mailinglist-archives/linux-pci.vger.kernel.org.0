Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C226D819EA
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfHEMrH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 08:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbfHEMrH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 08:47:07 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE952205C9;
        Mon,  5 Aug 2019 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565009227;
        bh=h7SfAciD2Px7XN6QUh4y+tAAK3kYv0LTgrkeiN8HNZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVZYaAUW0k4J9VxVFIKF7kW0vWTLQyJUPrq2chA0gTyWGbDpKXQDdFcITGr1wjveF
         tIx8SqLr8WtXounIvPTAXzaWApRbT8RnMroJ0lQzEJf3Hih/0ocyq333O7c9VRSxUa
         +vPjfAjOfZpb3sHYNtvfjK1o9yjXIUyQrxF0+YAw=
Date:   Mon, 5 Aug 2019 07:47:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Matthias Andree <matthias.andree@gmx.de>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: regression: PCIe resume from suspend stalls I/O and causes
 interrupt storms in Linux 5.3-rc2 (5.2.5, 5.1.20) on Ryzen 7 1700/AMD X370
 MSI board since 5817d78eba34f6c86f5462ae2c5212f80a013357, 5.2/5.3 w/ pcieIRQ
 loop.
Message-ID: <20190805124704.GP151852@google.com>
References: <935c6fd8-c606-836a-9e59-772b9111d5d6@gmx.de>
 <20190805122751.GL2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805122751.GL2640@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 05, 2019 at 03:27:51PM +0300, Mika Westerberg wrote:
> Are you able to get dmesg after resume or is it completely dead? It
> would help you we could see how long it tries to wait for the downstream
> link by passing "pciepordrv.dyndbg" to the kernel command line.

"pcieportdrv.dyndbg" (with "t"), I think.
