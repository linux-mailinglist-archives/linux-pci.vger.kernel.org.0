Return-Path: <linux-pci+bounces-32917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904A3B11740
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 05:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645D43AB015
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 03:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772CC1EDA1A;
	Fri, 25 Jul 2025 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0lVqjOP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DFA45948;
	Fri, 25 Jul 2025 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753415833; cv=none; b=Hgatxo7ZHu6QMcfzPfKOreejVui6xMD0iBwGG/IBEoEx1RqCN9BENxDcvJ0+hSiR9Lr7eeYvvm+HuGDQP/XJspF+VKKYXineT/jXZ3POgWMjPrNXlQ9+U9jFE+jUtZ91sY1AwBmsOCjF/+5Pu5VxyHArfOlM8bbuwsNnb93W18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753415833; c=relaxed/simple;
	bh=YH6RAbwnXm52oxSTqJO+Stc2BJQy94algtoEFpGIj8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHaaJ7cQSCLo3+ZH2/e6+ctbZ1+ACX6QYtorItUw5f2Dgv/L2mYheQGkyUPlcm1G44ixXIFCwAHLHrrUs7UiUmz7TB/aERHafu2OiNCFD+r65AG0fbtfqX2ySmp+BTgBO2TkTX3VMFsUOUw491E0O8ogAEOXW8Df01GUA9HwVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0lVqjOP; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab39fb71dbso18509631cf.3;
        Thu, 24 Jul 2025 20:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753415831; x=1754020631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qS0Z7r3EX0ZcTNJZb2kibKrC2Xd/v6RxpcgDmAdFoZs=;
        b=i0lVqjOPizCh0RpKO4dV8YQel8p46raWnGbXZV6XN9Rs0fDDHPmuGRz9quuifQcGnB
         dBwf80TXyp4b4OAHi1OmXBcCpqfvwyaa6IkolgBgtw0RMOxeUAYPlwbSpA7MLqfsRLfL
         XSMD19Ywl9FAjYtDlmR4fWekfo4Ck0ZzfURiT2rYH+GVyK6oaOggApFAv1HN3upEQ9ww
         2tU/LA9UV/rG/wTlAP4D7Fmol1ptu0dyrPul9HmWp/NOtaXFO3TA0G6aeQIxY0qatAn0
         knViKSbTSPuf/jK+8a5I3P92TTVh6nwDvVBSr80UgHaFRNs3YcJzKJ1dMlOwC/lKaC/K
         CNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753415831; x=1754020631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qS0Z7r3EX0ZcTNJZb2kibKrC2Xd/v6RxpcgDmAdFoZs=;
        b=WcVDVnHnwXFxBSD6g4xMUOirbDlIKRvAeVo7/7oXb07XVjMnw+iE7ZN659WfDnwkjH
         EUVn6uwQIfZpVghKYemlclqGlixPN98bx2GSAdvQdNi5szJZMCex4AfTl8efcfpz6S8a
         hYd5QHmCtuS3Viej+gr8HqJATI3auihgW+1ZOsEpe+8Zb8EdaSJ5CPj8IWVzSJFFJGyk
         pfRuTl5nXPcE+rirPBSflvAFewABKuTTTCUZNynFaY3PrCbgBC/TXpRAhDVnzJ9wLhe5
         sD78TQktwIWC4Y7hKUriVj2zmnEeqVoyYC3cWvonayQv2Tou6f6wp9vOH7nkxJQf/bkv
         1JZw==
X-Forwarded-Encrypted: i=1; AJvYcCWoUEMHdHMz0AzgDHAcZa3gA5hqzK70IDFIXiZFG5Z1IV9Z/o4WxY1Axu4mmX/pg7p0sxFktF7cVLJkpgA=@vger.kernel.org, AJvYcCX9ltCjsoxadXa8cAPWN6k7cihQ3OQK8pKH8a5xeGMj2s44BjC18rXnjC1Nj5r61REAOOzKc9Qir4Md@vger.kernel.org
X-Gm-Message-State: AOJu0YysZVH4Y2tYUtTO5ODDrUcBlP1ht2U3WEFzjbn0GsGB2WhAu4Y3
	dP2eaxYwuTJwp8fRSlSx/S3TT8UH4VM+tMLNi2fZlVlc8nR+hBhWpviK
X-Gm-Gg: ASbGncu6Wf4n11/7A7zm8WTahIe3l+1l+Fih2CWaE5wsO/Jf0igTbax+ardSknl5DyU
	8TqOfJpVZFWx596+ZxKeYniVyg4KQKQoIlRRPsJCwx4x0YXrMeXamBQQl0L81uCmoe3AUVxmJGL
	+x8C6NKHwa5ZMXFq0w3YaXWbiT/SkJNRNaUk1KMB2rWkI7gOahjZ57Mcj8K7QJI95I01nZOa8RV
	UeXvNOmO5Q89LX2Ec+1VzxRHG5LsCtsESANyp+sRY8/oseX3Z9PbzE3rtiD+4I3BDDE733PpTN/
	iGMMUdoqeugOzj7MEdxW5XkMrAd7jH/mNK71V9jNW8fKP9cpBXIMKfHFX3WKquV//TjV3CAgFMh
	yZrDwXejOaw1P/Q==
X-Google-Smtp-Source: AGHT+IGkfDM6npOStCLeJgu/CWVD68Q0/nsCWaHQZboVHGGZgry/9g6hSgC9hYmtKfgz39J9kvADNQ==
X-Received: by 2002:a05:6214:20e3:b0:704:f7d8:edfd with SMTP id 6a1803df08f44-70720602e3cmr5571786d6.50.1753415830648;
        Thu, 24 Jul 2025 20:57:10 -0700 (PDT)
Received: from pc ([196.235.221.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70714c88fa3sm16584396d6.91.2025.07.24.20.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 20:57:10 -0700 (PDT)
Date: Fri, 25 Jul 2025 04:57:05 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Use devm_add_action_or_reset()
Message-ID: <aIMAkbdOyHsiPeph@pc>
References: <aHsgYALHfQbrgq0t@pc>
 <20250724164217.GA2942464@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724164217.GA2942464@bhelgaas>

On Thu, Jul 24, 2025 at 11:42:17AM -0500, Bjorn Helgaas wrote:
> On Sat, Jul 19, 2025 at 05:34:40AM +0100, Salah Triki wrote:
> 
>   ret = devm_add_action_or_reset(dev, clk_put, port->clk)
> 
The second argument of devm_add_action_or_reset() is of type void (*)(void *)
and the argument of clk_put() is of type struct clk *, so I think a cast is
needed:

ret = devm_add_action_or_reset(dev, (void (*)(void *)) clk_put, port->clk)

Best regards,
Salah Triki

