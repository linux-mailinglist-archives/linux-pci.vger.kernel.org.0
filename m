Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA403397791
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhFAQNO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 12:13:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhFAQNO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jun 2021 12:13:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EB7860232;
        Tue,  1 Jun 2021 16:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622563449;
        bh=/ypgGqL0v+wsCgxDS8k0oLpREu5q7GxXgSi43vcKhcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DH17KwsxplYIBl3YflGFUaRCGNMjISN1k6KMivXnfOqr5k0Q3eQWdrkFOp/lzW/1g
         fPv+4slyk5DCica+zDVOHa/+hMq5PcqCuVFyCYeLdg/VKfzNPrV+1mFrLQ9vJ/TxrD
         ljfdK7MP0vekepdZtNmFDoltBRGXzTwArD0hjVb/+MVn2/mHY4HMhexmShffv5w7m5
         8I6qHHL6zC4YginEDR6Ho/UWPedEtB4pyAV5Lx7yzhr1Kmo1+1nIWNIFUIsyRyi+N6
         Q87kXii61tZKgkMYYZLQthvPOo2jhRJw4I25FNLHH6o3nmrqe0ihANcJ5A1siIwf4J
         6OcH6tucNV2Kw==
Date:   Tue, 1 Jun 2021 11:04:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wesley Sheng <wesley.sheng@amd.com>
Cc:     linasvepstas@gmail.com, ruscur@russell.cc, oohall@gmail.com,
        bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wesleyshenggit@sina.com
Subject: Re: [PATCH] Documentation PCI: Fix typo in pci-error-recovery.rst
Message-ID: <20210601160402.GA1944037@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531081215.43507-1-wesley.sheng@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 31, 2021 at 04:12:15PM +0800, Wesley Sheng wrote:
> Replace "It" with "If", since it is a conditional statement.
> 
> Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>

Applied to pci/error for v5.14 with Krzysztof's reviewed-by and
subject "Documentation: PCI: Fix typo in pci-error-recovery.rst" to
match previous convention, thanks!

> ---
>  Documentation/PCI/pci-error-recovery.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
> index 84ceebb08cac..187f43a03200 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -295,7 +295,7 @@ and let the driver restart normal I/O processing.
>  A driver can still return a critical failure for this function if
>  it can't get the device operational after reset.  If the platform
>  previously tried a soft reset, it might now try a hard reset (power
> -cycle) and then call slot_reset() again.  It the device still can't
> +cycle) and then call slot_reset() again.  If the device still can't
>  be recovered, there is nothing more that can be done;  the platform
>  will typically report a "permanent failure" in such a case.  The
>  device will be considered "dead" in this case.
> -- 
> 2.25.1
> 
