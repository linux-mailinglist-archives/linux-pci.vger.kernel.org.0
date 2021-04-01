Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC4350CA5
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 04:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhDACWm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 22:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233149AbhDACWX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 22:22:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF8406101E;
        Thu,  1 Apr 2021 02:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617243743;
        bh=7fpB01V9okBIES6A2BYCsstRs/fHBEhl76Zxlh71QWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JgDpvGCV8GiVLeznM87+319a/tDlDTmPVTrqf5mnmeCu5VR+DnSW/aeW65Xs0MkfC
         OSikDe1+COfy/VeGBwzBl9Dx7w/EkhoAHWoTMq9YnlmcatpjhzP97z+BO96HdTEYyM
         9pBNzQRS4H8BZfhD+AOAAA74IphixAhWvdso7i/dQZxVQ65bEPKNEtU0w8fXveL11W
         5J4VJ5slDZzZj9rg+ApXBLx0jaTT+tjBlElD6KoPWzpmntB6gbXMdtn6ByF7a/vkRy
         msjcoZIeSKirwn0tMlRcRtKssIMLEhlYY0kOvKWfVYMhTbxeLyx7puPmVsieFe5uTo
         nw3uKHHYXc5aQ==
Date:   Thu, 1 Apr 2021 11:22:17 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [External] : Re: pci_do_recovery not handling fata errors
Message-ID: <20210401022217.GA29196@redsun51.ssa.fujisawa.hgst.com>
References: <MN2PR10MB4093188B8CDC659AE68E5640996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
 <B2696632-CB84-420E-B072-044603A6D3B7@intel.com>
 <MN2PR10MB40933D5232D0F58ECAF4387D996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
 <20210313171135.GA8648@redsun51.ssa.fujisawa.hgst.com>
 <MN2PR10MB4093780C86ABFCAB54B1427C996B9@MN2PR10MB4093.namprd10.prod.outlook.com>
 <20210316215137.GB4161557@dhcp-10-100-145-180.wdc.com>
 <MN2PR10MB409355791E03C3C8D66A9066997B9@MN2PR10MB4093.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR10MB409355791E03C3C8D66A9066997B9@MN2PR10MB4093.namprd10.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 01, 2021 at 02:15:38AM +0000, James Puthukattukaran wrote:
> What's the rationale for overriding the status returned by the err_detected callback with the reset_link in pcie_do_recovery?

That was a bug that's been fixed:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=387c72cdd7fb6bef650fb078d0f6ae9682abf631
