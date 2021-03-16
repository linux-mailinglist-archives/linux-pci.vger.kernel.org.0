Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3334233E0D4
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 22:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhCPVwE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 17:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhCPVvk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Mar 2021 17:51:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79E0E64F7F;
        Tue, 16 Mar 2021 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615931499;
        bh=1dlwSxIn080Cz8h9ZB5bPtYR4a5WcYyKwGw8e8anLZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceC+lwnNbmunNQUlsdrEozfHeLunLF1U28tKAiucsWcLhg03X4p7gYsoHhmY/hZge
         mlFqtB1DqfvYLEh4+x81x9UG73ODHOzmug+LQmD7pXKJsq+PsYdqLb3Ljv/WNw1s6E
         GXEIT2CZQh4nk9o5Bj+OfA9/owv+GJq2czsmCZDBbH1O4a9J6eZYedqm4bNMNPgX/L
         HJoYqtUTcZ30VySul2Mxdn/I9mEqcVoyVmJfjmwHcjKIv86Ng5pQNTkZ4uaNXBqSOc
         y8IOgp5OKg/P6ww/4EIUMARNlznbnX6M6xj5oBrSxHw4KEjynhBThgjY2dc5bQOad8
         6pRjcojKeBn5g==
Date:   Tue, 16 Mar 2021 14:51:37 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [External] : Re: pci_do_recovery not handling fata errors
Message-ID: <20210316215137.GB4161557@dhcp-10-100-145-180.wdc.com>
References: <MN2PR10MB4093188B8CDC659AE68E5640996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
 <B2696632-CB84-420E-B072-044603A6D3B7@intel.com>
 <MN2PR10MB40933D5232D0F58ECAF4387D996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
 <20210313171135.GA8648@redsun51.ssa.fujisawa.hgst.com>
 <MN2PR10MB4093780C86ABFCAB54B1427C996B9@MN2PR10MB4093.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR10MB4093780C86ABFCAB54B1427C996B9@MN2PR10MB4093.namprd10.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 16, 2021 at 09:13:56PM +0000, James Puthukattukaran wrote:
> Keith -
> I understand that the RP did not detect the error and so nothing to
> clear in its AER register. My question is - where is the fatal error
> register cleared in the device's (the device that was the cause of the
> fata error) AER register? It does not seem to be done in
> pci_do_recovery walking the hierarchy (unless I'm missing it)....

Gotcha.

All pci drivers that implement error handling should be calling
pci_restore_state() somewhere from its .error_resume() callback, which
invokes pci_aer_clear_status() to clear the device's AER status.
