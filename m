Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B3337FAD4
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhEMPgi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 11:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234896AbhEMPgg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 May 2021 11:36:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8111C613C5;
        Thu, 13 May 2021 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620920127;
        bh=qbmpfU9jlI9PfGpLpoWrjUdG9T1Q2juy5Cf6iPi4ZPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAQ7I1CiXLTSAA6joQraUXBNf7sRz6Go1w1/NUWoD2Z2XURN8nirw1bKlPHrCDomz
         9G2Tf5Yxwqe2FAs+iW06zcgF2G370TuP1z3qSsf3lyEWeZk9AqMg9yzUCmTOXSroDN
         OTz4+rpWhUlG6B1asdqWG9HckfCc/SHsNGGhQyWHUbEb0uA/Wj5X4k6LEZ6iEuNxdc
         uMwMqiYCNduWOSpJdPG2ixge5DfveAnixsFq20xk/u5R9fpvtJqZA0ma2VeQummcUm
         jnoCfQAlbf4idJpo3EXOKLgen5X8EXxGU9n0AYGxYxA55MZi5X4B+MpgK1YnZSnRgB
         Hki4GJgYK5ZOg==
Date:   Thu, 13 May 2021 08:35:23 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "linux.enthusiast" <linux.enthusiast@protonmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: How does the "/sys/bus/pci/drivers/*/*" interface work?
Message-ID: <20210513153523.GA2272284@dhcp-10-100-145-180.wdc.com>
References: <bO6tTSRbjFucyxFz_SsgnnkT6H40xY428tQCVi64ig-N6nVg_xxyHzjb7m31oMu0VRSDjMRt9DdH3jMg7sefDSmx-XEyh-Htr3x9o6AU3hk=@protonmail.com>
 <20210513144650.GA2272206@dhcp-10-100-145-180.wdc.com>
 <CTXLhLhp53xP5tJrXVibXRGGcF5MG4zpXCnmm_NkF-3GbkH6nC9JpkqLtfeEXfTKV8JJgKsdyaG35rJhMbofPADFCIhdTHWXqC2DEqxdsfU=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CTXLhLhp53xP5tJrXVibXRGGcF5MG4zpXCnmm_NkF-3GbkH6nC9JpkqLtfeEXfTKV8JJgKsdyaG35rJhMbofPADFCIhdTHWXqC2DEqxdsfU=@protonmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 03:25:50PM +0000, linux.enthusiast wrote:
> > Documentation/ABI/testing/sysfs-bus-pci.
> Thank you, that was incredibly helpful!
> 
> There's just one thing that I couldn't find an answer to and that is how to list the current device IDs of a given PCI device driver.
> 
> I mean I understand there are default ones and that I can use `new_id` to add dynamic ones, but I don't know how to list any of these in order to know if a `new_id` call would even make sense.

Run 'modinfo <name-of-driver>'. For pci drivers, each "alias" line will
show some kind of pci information that the driver binds to. For example:

  # modinfo nvme
  filename: /lib/modules/5.12.0+/kernel/drivers/nvme/host/nvme.ko
  <...>
  alias:          pci:v*d*sv*sd*bc01sc08i02*
  alias:          pci:v0000106Bd00002005sv*sd*bc*sc*i*
  alias:          pci:v0000106Bd00002003sv*sd*bc*sc*i*
  alias:          pci:v0000106Bd00002001sv*sd*bc*sc*i*
  alias:          pci:v00001D0Fd0000CD02sv*sd*bc*sc*i*
  <...>

The first "alias" binds to any vendor device that has a matching class
code. The remaining lines show a specific vendor:device identifier.
