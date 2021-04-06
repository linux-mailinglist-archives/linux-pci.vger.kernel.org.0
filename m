Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04D4355B2B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 20:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbhDFSTB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 14:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237779AbhDFSTB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 14:19:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1375261205;
        Tue,  6 Apr 2021 18:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617733131;
        bh=41zKhZqqt5fyXsSfWVsAeg0IHA9Ft0T7ZsDcJDmqVL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDbKYS2CE25dynfCZmJhxoo7EubDdX0f9Mr5z2SEPSWGICYq88UENVlBDlcMLOtKM
         udfxFqWtIZac+zhpbWL5rVQhMBLweWeohGtKWG2/HZnSySwTCG55kb9oDBf5TAJxZd
         Z/FuqKv3GocOONltDwiXDF2YtKT/RMcYoETiDMkA=
Date:   Tue, 6 Apr 2021 20:18:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Documentation: misc-devices: Add missing entry on the
 table of content related to dw-xdata-pcie
Message-ID: <YGymCRJ9w44B+rt3@kroah.com>
References: <1fedd7b269b5d5543333340c44f0a917f578389d.1617732463.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fedd7b269b5d5543333340c44f0a917f578389d.1617732463.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 08:07:43PM +0200, Gustavo Pimentel wrote:
> Add missing entry on the table of content related to dw-xdata-pcie misc
> driver reported in a warning by doing *make htmldocs*.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  Documentation/misc-devices/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
> index 64420b331..30ac58f 100644
> --- a/Documentation/misc-devices/index.rst
> +++ b/Documentation/misc-devices/index.rst
> @@ -19,6 +19,7 @@ fit into other categories.
>     bh1770glc
>     eeprom
>     c2port
> +   dw-xdata-pcie
>     ibmvmc
>     ics932s401
>     isl29003
> -- 
> 2.7.4
> 

Is this before or after your other patch?  Please make this a patch
series, and provide proper "Reported-by:" as well.

thanks,

greg k-h
