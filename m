Return-Path: <linux-pci+bounces-25728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 947C2A8724D
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857AC173CAE
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205951A2564;
	Sun, 13 Apr 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGVvgTTk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7376019DF5B
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744557177; cv=none; b=LRVe7cQ8LIL73spDHRxr5rQjSaoZ5FT1UzZDW2EAxYKVhbUqv0W47hyLKNqQFKCgr1Q9zB9RiRQ6KdZL5fBXKai5dIVdokZjpLx+DPCHDEBBXoTMIGA63Jy5DDSP3TExnPoHywHHnIgs/XIZI53u9oWUMuFSd9tBrqDGMHRLSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744557177; c=relaxed/simple;
	bh=phS3D5OOOkm6noFR0FYDt75hv1VoWhQUHvXWkLWoIaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7fsaXxAdYLNqDV/sHdsDrNcKx1/BLEmQjIYZDVYK6XfZuoda1924V+697v4OVNkWG3406HdbnRmOPHm0hgWLdRvdgZcNkUDzpncY32MLRWXq5OvqVC5e5gUkWwDGlakRbzLsjuezdk5tjmpwMfePblYsB1hP0drTSa1v25uzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UGVvgTTk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22622ddcc35so46487235ad.2
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744557175; x=1745161975; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vj0Jh4u4n9sOWnZj41OkfdidrvtJgy6o9CdCA00I7q0=;
        b=UGVvgTTkbQNGa4dIjj7oBOjfyPn29NY5aUMhSrH7MVRGn7R2HSwZ3GzwnIcgQZRGdc
         WIv2EhSFzS721UaalquqEGVC4kgHDrbBSt5o5+0FZhC3+0L6S+7YDi2KVVhlnHfi9Ehw
         Kt26KcymYB5JZ/HeBHW1a2XCYIfpFZfWNOOXa4L0EQDghM0w+6YIPyBNOG270ZP1qP/5
         sda2aQT8R6503ICP2fqZ3No8mAqOCph7WNILCPLgKBjAY6CXJbiB6YBHFzCwuBLH4L22
         4Jr4kRYH6oc/bCdYO7/5fRJvPCDzV0aHOM5GRMkDJubpX4/B8omU7sZLUKZYMkPxP0ap
         1vrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744557175; x=1745161975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj0Jh4u4n9sOWnZj41OkfdidrvtJgy6o9CdCA00I7q0=;
        b=faPJ+sG++G/GEpQjwAc9HlHvFHE1dbKKfgPm5JR5TN7VSOZwY6kG8/7TPGftpATxaP
         9eETe24fWDOye/aHzx7G/fqc6pfCE2V45nLu3xKjIgE29saawva104CH7MHyrtcHPeUt
         qNfBO6PkK4Kcuih6VhO7lrEXXtjK5oo581Y4Jpl0TwOYjL3/05AiucrN/CqbYVeWNfqc
         xWWJnXadT+UyeemjY5/5X7c3qmJhnoC6ok9NzKyEmE+OmKFC7g5aC9nwo58eFp1Nm5KN
         LH0QkCX1nhzKsmPOWS5CAAmFfx714tjltmgsUfi/784JXoDbGNvLL9Ct5N/Gh+RNG4pl
         t3kg==
X-Forwarded-Encrypted: i=1; AJvYcCXhC/6QyzY0YV91N2mhhxXqAdMJWqFwPtJehi35RTdayqw0pkcw2uPsA818KbyxROOkvI9f6qigND4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsk3bSjBj2g2zb3W0h0zaekfdC8iGt9AoDUrFuCWnS7ZN5ZPx
	J5lMrqQyFlE+ZG/TokvXa/I7DEUNQ6k6hnJzqmYlWSAW1xU0sX0VbJLFaWhuWA==
X-Gm-Gg: ASbGnctmBpWEdbse4AOTU7gj8nUFRRoAlKhejjyufYNKGkSHFmAat4W+waf/4+cHDlP
	8zC7UD6ywq2jN4lm3iKQuTDVIo9XOdFqJBIr5ul4KzyMKNMMOC5db8tkoAFjMAknCNPFlVJHVwa
	V2/KXR3M1j7Ujal7gwE9Wl2mDgHTBLiV5gBOg9AMLF4GH+/COLtAgqSDInCf4Tc2vVvXuDtp7tu
	8PhFwHu/z1jrW8Ro4pmFalP1XLhKVGgCopSaCnpcYSY/jT9q1ZFUm1aedyuZVPiah3NwQC9/uw5
	G41hU1ndY7328wWDEJ80sTmUsZ6kU9LkLhXjdB+lcJvH1zny/2jD
X-Google-Smtp-Source: AGHT+IEl1mfp4h8joqe88PR+eqAgq+GkZLNrPfPvCZVzAzUCEhJOKuX/kTRe8Qw9Vvxua7aCf7iBqA==
X-Received: by 2002:a17:902:d484:b0:223:517a:d2a3 with SMTP id d9443c01a7336-22bea4ab6abmr108986985ad.17.1744557174513;
        Sun, 13 Apr 2025 08:12:54 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd18580esm9589319a91.46.2025.04.13.08.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 08:12:53 -0700 (PDT)
Date: Sun, 13 Apr 2025 20:42:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] PCI: imx6: Skip one dw_pcie_wait_for_link() in
 workaround link training
Message-ID: <2hbtwy3tfzip7dglixhcipaykxxg3ph6hy3bwn5ujmvj75mwvy@6qcqptbakkey>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
 <20250408025930.1863551-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408025930.1863551-3-hongxing.zhu@nxp.com>

On Tue, Apr 08, 2025 at 10:59:25AM +0800, Richard Zhu wrote:
> Remove one reduntant dw_pcie_wait_for_link() in link traning workaround
> because common framework already do that.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index a4c0714c6468..c5871c3d4194 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -881,11 +881,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	/* Start LTSSM. */
>  	imx_pcie_ltssm_enable(dev);
>  
> -	ret = dw_pcie_wait_for_link(pci);
> -	if (ret)
> -		goto err_reset_phy;
> -
>  	if (pci->max_link_speed > 1) {
> +		ret = dw_pcie_wait_for_link(pci);
> +		if (ret)
> +			goto err_reset_phy;
> +
>  		/* Allow faster modes after the link is up */
>  		dw_pcie_dbi_ro_wr_en(pci);
>  		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> @@ -907,17 +907,10 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  			dev_err(dev, "Failed to bring link up!\n");
>  			goto err_reset_phy;
>  		}
> -
> -		/* Make sure link training is finished as well! */
> -		ret = dw_pcie_wait_for_link(pci);
> -		if (ret)
> -			goto err_reset_phy;
>  	} else {
>  		dev_info(dev, "Link: Only Gen1 is enabled\n");
>  	}
>  
> -	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> -	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
>  	return 0;
>  
>  err_reset_phy:
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

