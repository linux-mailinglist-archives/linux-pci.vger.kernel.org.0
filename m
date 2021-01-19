Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77FA2FBF05
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 19:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbhASSbS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 13:31:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387837AbhASS3Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 13:29:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF5D22AAA;
        Tue, 19 Jan 2021 18:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611080907;
        bh=VSOoRv/3Qk+u9ct02yQLVhqZ8mMGF7fspCDr+TUY1WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HC8t9aonH/DLVb1TwA+X18342cIZSjqTpwMyy8i8B5M52PAUyGCi9aotaImXZO6Vj
         3cbu31KUwU7hadia41Tur0OMC57e5kcV5Qjxq92aIIsI/MLIwoiuX7/BYnzI/6AkO/
         KJgnuRbQHc82alBVq2lUqigX9fs7iO/L74gEij5ksXYYPlYNVfV0SLjWYO9pZZVEjB
         K0FJMvKG1OwzAYsWspdAn/mm6NypIFmkO6qSPvL60OPDS9ejSkhsa3MjN6Mdc9Eytp
         Rge8Sy9vUd04rThjMuEadTTX4LBPXE+/QdJkyxVGjqaofA0aiJk/KUDojPosTP82R8
         hcR/PwKWbE2hw==
Date:   Wed, 20 Jan 2021 03:28:24 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Hinko Kocevar <hinko.kocevar@ess.eu>
Cc:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Message-ID: <20210119182632.GA23186@redsun51.ssa.fujisawa.hgst.com>
References: <70f2288d-2d1e-df82-d107-e977e1f50dca@ess.eu>
 <c3117c51-144f-ae59-ad68-bdc5532d12cb@ess.eu>
 <20210111163708.GA1458209@dhcp-10-100-145-180.wdc.com>
 <6783d09d-1431-15fd-961e-3820b14e001e@ess.eu>
 <20210111220951.GA1472929@dhcp-10-100-145-180.wdc.com>
 <ed8256dd-d70d-b8dc-fdc0-a78b9aa3bbd9@ess.eu>
 <20210112192758.GB1472929@dhcp-10-100-145-180.wdc.com>
 <8650281b-4430-1938-5d45-53f09010497b@ess.eu>
 <20210112231744.GB1508433@dhcp-10-100-145-180.wdc.com>
 <008a7051-dbad-abd2-6cf8-52433f453b42@ess.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008a7051-dbad-abd2-6cf8-52433f453b42@ess.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 18, 2021 at 09:00:34AM +0100, Hinko Kocevar wrote:
> With that being said, I believe that this patch series is working for my
> system and the issues reported were related to my system mis-configuration.

Great, thank you for confirming! I couldn't think of any reason this
series would introduce the behavior you were describing.

Bjorn, do you have any additional concerns?
