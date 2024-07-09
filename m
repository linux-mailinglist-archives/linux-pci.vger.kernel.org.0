Return-Path: <linux-pci+bounces-9997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8AF92BC59
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 16:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C49285F92
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1B518FC76;
	Tue,  9 Jul 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HimCvSTo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B018FC84
	for <linux-pci@vger.kernel.org>; Tue,  9 Jul 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533565; cv=none; b=uMjcVQs2GAf6hdJwsV8+Gxg5fbPnOyUaT7B+zd5nwGG+JjtkFSrTaYSlEik0A+qUaZk4rMGarlM82j5JH4BWM0Jo/rhUwOUdhVWuaP+ID4Eq0hkqs4HPQMsurei89v8/URfdCj+haGuAIdHamVidcVwQv7XoWrmSUnx4KaOxxGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533565; c=relaxed/simple;
	bh=4ZY3sgg/UcXc1lHmildNgyCCyNnIQNIHYrRURZgokIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFB4xiV/gM0Z7fhGnPZ7XJnrVMWNBPfdYVU0zKMyKGRO9g4rwIfFJomlrhfdU8Ncg3XPcZAnOVbJKyukzXqMFpMp7Fea0u6ZonnaxQyPNQlEs2OXvM8yt3Y7ZXDjABWSMIGJXHaB7DyTsztQxUP+y0lEBrz9HTnxWKcMfmrAN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HimCvSTo reason="signature verification failed"; arc=none smtp.client-ip=209.85.167.177; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e9fe05354so7600427e87.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jul 2024 06:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533562; x=1721138362;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:dkim-signature:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBVMyiTluWvB+cspxCg8zTmg6u43rmW8xruXcjUcEz0=;
        b=gIt8EEeHl0qa6IFuMh3wafe/iL1+Xg8dI1Q19VQeOiE/ThAgMnDJYNGljZZnUJXJbR
         Z5zNC+IqI8v6OyJhOCmPEhv5hu00OLhiph1wmtfKkOHMp5dCVCRi60MiL/KqDbBlF0lO
         VnSNCJRCZmrdtzZlOCGa14/PTtN4q1gsD5kwHs+BOGWuY/hAYoSfwTUYq+QtTHjY2ZSF
         wT24Jj/EkirKA6k4RKdikjJf6Q/nMyu5M8GKmrOmXhIdnLXltbuvDw6Uu1rbpYF6Izw3
         ivpEhbu3/BNlLMcU/LFpDwCLKO+zIgHE4yfbxl/NfDwUwYRk98WZU+JxyvDyqfKKYai5
         Xn9w==
X-Forwarded-Encrypted: i=1; AJvYcCUVmI1XFV2ug/REIwhQcCxakTXc9WqkfMVNxnl2dzj7hdWtDjvOQy79Zu5EXpGBv7f+iQ5y+6xJgcpZzGyecm71/jHgzjD8Q6Ua
X-Gm-Message-State: AOJu0YxbQ8EAWJSBIlIMbnzCGBIohBjaC90/TUVl9KRkiQjrgQvqaGK8
	jZJaFDxrlCnhEg1xhP6oCZElm2NUaHR2f4jdU+uAl+J4zo0wNLagZjFoiKmYXQQ=
X-Google-Smtp-Source: AGHT+IG/rFtXKbzfzIclsUAgMeGPHLkGwdyOR4dLpOuhjgwOVsd7Rde9H5nBfdSfvRYOMEmvNTFStA==
X-Received: by 2002:a19:5f03:0:b0:52e:934c:8e76 with SMTP id 2adb3069b0e04-52eb99a324amr1552711e87.41.1720533561657;
        Tue, 09 Jul 2024 06:59:21 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e3473asm252107e87.36.2024.07.09.06.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:59:21 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: dan.carpenter@linaro.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: bhelgaas@google.com,
	kw@linux.com,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/3] PCI: qcom: Prevent potential error pointer dereference
Date: Tue,  9 Jul 2024 15:59:18 +0200
Message-ID: <20240708180539.1447307-3-dan.carpenter@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708180539.1447307-1-dan.carpenter@linaro.org>
References: <20240708180539.1447307-1-dan.carpenter@linaro.org>
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48AB148FED for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d92aa6b62bso1204955b6e.2 for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google; t=1720461948; x=1721066748; darn=vger.kernel.org; h=content-transfer-encoding:mime-version:references:in-reply-to :message-id:date:subject:cc:to:from:from:to:cc:subject:date :message-id:reply-to; bh=hxcirFeeuu0bt0rjz0tmui1G8RYDC+/JunVt8zPPRlg=; b=HimCvSToBRd0wyTWybX3iK/ljx9N7x5Kf6z/EztaEn00F9+Rc/ww6NWSERNxX9I4Dq u+UtQxi3iXxQNkDgvdHx1UcsqntPliN62vvsQ/GpcQJ4E0ypmkDJXAOVxHxd6mlNy6dc MOICnrtX6KhNXfaca8UTv6HI554B4n+jJx1IDSv4xX9gJeaJZsWWfunwwb1hcmouE2YD iqs1oXW97dkfpIPtsOx6NQSWjGMcvUbOxSUqfi+dLduw0+Nc6ghLHJvkcSnMMnX55gsI aQsIJitQOMgWfJpL9DFN3ZhRmfzZGNEIPU3akNE9B06+1casa95QtMuz3eJfAtGvIH6X Y7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwkqYAK6ZlIVETdJ8PeCCcKNQFBLOYM+DRSFLgaiM1ECxyPZiHVwhel4bQLtJujradn601FDr1Yh33VRIJ/DMVc9/kp/BwodUj
X-Received: by 2002:a05:6808:10d5:b0:3d9:3802:3855 with SMTP id 5614622812f47-3d93c02038bmr176901b6e.23.1720461947976; Mon, 08 Jul 2024 11:05:47 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:cdd0:d497:b7b2:fe]) by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93acff184sm76287b6e.10.2024.07.08.11.05.47 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Mon, 08 Jul 2024 11:05:47 -0700 (PDT)
X-Mailer: git-send-email 2.43.0
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

> Only call dev_pm_opp_put() if dev_pm_opp_find_freq_exact() succeeds.
> Otherwise it leads to an error pointer dereference.
> 
> Fixes: 78b5f6f8855e ("PCI: qcom: Add OPP support to scale performance")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Applied this patch ontop of linux-next tag, next-20240709.

Booted fine on dragonboard-845c HW.

Cheers,
Anders

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 1d36311f9adb..e06c4ad3a72a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1443,8 +1443,8 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  			if (ret)
>  				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
>  					freq_kbps * width, ret);
> +			dev_pm_opp_put(opp);
>  		}
> -		dev_pm_opp_put(opp);
>  	}
>  }
>  
> -- 
> 2.43.0



