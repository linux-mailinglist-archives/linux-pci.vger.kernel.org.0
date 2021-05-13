Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67E237F9F7
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhEMOtB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 10:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234595AbhEMOsC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 May 2021 10:48:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 698A461260;
        Thu, 13 May 2021 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620917212;
        bh=uRqEog0EjpS3RZfzPweXTtAdKm4PZnfRy4R/jDA0pa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkqNFF2dD5fDhB6dd3wlUxgB1offXVm7r1HDzmpy0r5h+3n4VbHM/EiSJBq+Za9oF
         gt/oDoeOoSkTKXQJzfRg2Cp1SZEGTlkv1a1nMtgsKh4gzgkLTGonblIANUgNYs5X97
         UmeWbEQmkQpK8u++H9emN17gugtLnParrBd4t8qLGI/1eFrqpdr9VAnlE2UpIN6nTy
         0ORfTKrgFC5pu/IOVyOuM47ujKIrEgbxTkeeNH9nx+7evvY0CX0vQMgPg+jTjPHNPv
         x+y0mu/HdzHn62mRy9gcIcOkN1TX+phu9aktMK/9d1nJL5HSuLJR3gs7XvQXv4i4H0
         5CEASnj60DowA==
Date:   Thu, 13 May 2021 07:46:50 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "linux.enthusiast" <linux.enthusiast@protonmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: How does the "/sys/bus/pci/drivers/*/*" interface work?
Message-ID: <20210513144650.GA2272206@dhcp-10-100-145-180.wdc.com>
References: <bO6tTSRbjFucyxFz_SsgnnkT6H40xY428tQCVi64ig-N6nVg_xxyHzjb7m31oMu0VRSDjMRt9DdH3jMg7sefDSmx-XEyh-Htr3x9o6AU3hk=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bO6tTSRbjFucyxFz_SsgnnkT6H40xY428tQCVi64ig-N6nVg_xxyHzjb7m31oMu0VRSDjMRt9DdH3jMg7sefDSmx-XEyh-Htr3x9o6AU3hk=@protonmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 01:49:58PM +0000, linux.enthusiast wrote:
> My problem is that I can find no official documentation on these "interfaces" (`bind`, `unbind`, `new_id`, `remove_id`,`uevent`).

Except uevent (that's for udev), these are currently described in
Documentation/ABI/testing/sysfs-bus-pci.
