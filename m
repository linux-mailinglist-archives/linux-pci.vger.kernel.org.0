Return-Path: <linux-pci+bounces-22076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C14A40628
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 08:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B5D177BA3
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 07:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A976205ACF;
	Sat, 22 Feb 2025 07:53:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC9158D8B;
	Sat, 22 Feb 2025 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740210832; cv=none; b=KXS6DYtmFJoecklh3olxgiuc/5RQFK5XC0IE3HAeYFK2g7nSsceq9xHjymbxro9gHSMCmwhZtpp8v7BzmB4gm3JlTkfbYp1fNBB3YLoric9fzapOr4j5V7WrJUexXODX306c512w3SAvqdTFKfFHmoV2RisxC8dYGIzsN+t4tPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740210832; c=relaxed/simple;
	bh=3PI9LZ/oRJ5/z4xPX/rDQSoMv39x7OHyntDEUSyHW6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma2cR/iOOchlDrzR49HKuT69mdIaqkHk72RAk/y3asuFS/dSsxQlSgATwfFl66FJy3koQvUB8dWv+xJdS4aC0nV6RByDNzZTFcHYuFM91Eqh2bAp+6uBJZJKyZ4EDg69RDB6DQcTinhbAzTwgZLCxvI3Kqqt17mm4BSrFmXH0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso5048654a91.1;
        Fri, 21 Feb 2025 23:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740210830; x=1740815630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgOwBKeJIC++w2hXb/vSOONHow+D0phrb0BF5CSn77Q=;
        b=ln1rQ/qCjOFs+IZQEUMKP5eEXusDct1Cr11yZC6Vhx0FKlpUrzp3wAZ6JACugNUcCY
         29Q68n5uHZ3k6ymnPWqTxguRZwKekOOcgZZmF1xyC+KcKJRLP2HHlZAxuNmbT30Z7hvJ
         wMkwaOWzHYwMDhQ5/E8fyySiJhJLG54nCr+iUOWZQwx/EuCHGuRMFeGgb+Jdqvl8TJNT
         AeNkOrGkxNdG4bJyqh2wQuQvx5t+JaY5bIEDivlFnatR5r36V1JFxcTI/4kgcLJz2L63
         ZRfuBEQUCBR5A4sqQTj1VQTTdYKme/gmtc0JSt60/1OVEL7FGGuJ66tF5I3COtj9pde0
         wcOA==
X-Forwarded-Encrypted: i=1; AJvYcCU3IZTTJ2tmWJVdI+sUlfRBO7xKtm/yQ3/0KWROYjaesQ9CzWrCya1jOpmwDTY4MAOn/ZywF2QAgfWa1292@vger.kernel.org, AJvYcCULn1achqslT7CddV7ogXwFBJOcSQbCVRWacoXXS28TmfBgyp9rZeO5x9ZeRQRJVzjq98+cIGxRMxhv@vger.kernel.org, AJvYcCW68rID9XYKGdne9KzA4fQ0maxm8yTGOwPZ/FUImYu0Q4wFG9gvwBwXE17zshGE4LqEQ91rG/iLhKxTeYrD@vger.kernel.org
X-Gm-Message-State: AOJu0YyazKoHfmN2YSb3n2hD/yT9Ng+7ueuVB9tZxdyktTfbZQBHOJJI
	YLjQPQJLvKe6JXGqL8+jD9LpVS/IhFEQMFYksHWEEe724j3+hw1Y
X-Gm-Gg: ASbGncvGnbTdt0u3Ly/bmKCCRZi8L3pDLjbNCWavDkfHZKig3/Sm6ZELhx7P0sKnwLV
	1dA/LZXUgBnQy6gJt64Zjp24dz4Kjf2OSwdoecjnSxOrANR7p1Ev5K6ldqo6svEWJsJOvmUcI6z
	ASZysMSVhs0OC1xbeuXTV4qmWAnMlmW0UMFDgMUx8Ml8fNb5USv8tXCbzxVNmwBiyIwjkPFPeg2
	Ec3YM8qHMAzvk+8A5SLtQ2dVA1GLlUDI13k/d3cq5b5Hx9Gp92cQ0qrhhXb2TA62ynLUjmh2ki3
	S5xxlZQMqdQE+IND8yNd7vKOhM/pOAfHHmBFcuONDWg2mAzqaJ450eHZkvmv
X-Google-Smtp-Source: AGHT+IGBa2sUv3RRiY4KoSYaepkpXMCwBkVIcmu8mOMY6NF2khmYEc5MAiG7hTleu61bz7O7mg4ASQ==
X-Received: by 2002:a17:90b:3dc3:b0:2fa:1d9f:c80 with SMTP id 98e67ed59e1d1-2fcccc92715mr17441423a91.17.1740210829827;
        Fri, 21 Feb 2025 23:53:49 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d55b6ab7sm147107975ad.132.2025.02.21.23.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 23:53:49 -0800 (PST)
Date: Sat, 22 Feb 2025 16:53:47 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	manivannan.sadhasivam@linaro.org, quic_shazhuss@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_nitegupt@quicinc.com,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Slark Xiao <slark_xiao@163.com>, Qiang Yu <quic_qianyu@quicinc.com>,
	Mank Wang <mank.wang@netprisma.us>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/2] pci_generic: Add supoprt for SA8775P target
Message-ID: <20250222075347.GC1158377@rocinante>
References: <20250221060522.GB1376787@rocinante>
 <20250221215445.GA363532@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221215445.GA363532@bhelgaas>

Hello,

> > > This patch series add separate MHI host configuration to enable
> > > only IP_SW channel for SA8775P target.
> > > 
> > > And also update the proper device id for SA8775P endpoint.
> > 
> > Applied to epf-mhi, thank you!
> 
> I see "[2/2] PCI: epf-mhi: Update device id for SA8775P" on
> pci/epf-mhi, but I don't see patch [1/2].  Where did that go?
> They seem related, so I would think we'd want to merge them together.

I asked Mani whether he would prefer for me to take the entire series via
the PCI tree, but he said that the first patch should go via the MHI tree.

So, I assume Mani will take it, then.  Mani, thoughts?

> Also, in [2/2], I guess the .deviceid change is known not to break
> anything that's already in the field?

Mrinmay, are you expecting any issues with this change?

Per the c670e29f5bfe ("PCI: epf-mhi: Add support for SA8775P SoC"):

  Add support for Qualcomm Snapdragon SA8775P SoC to the EPF driver.
  SA8775P is currently reusing the PID 0x0306 (the default one hardcoded
  in the config space header) as the unique PID is not yet allocated.

I think, we should be fine.  But would be best to confirm that.

	Krzysztof

