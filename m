Return-Path: <linux-pci+bounces-35515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1203BB45021
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 09:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC0B16DA5F
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 07:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D899265637;
	Fri,  5 Sep 2025 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LKtWmL/9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A4263F2D
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058210; cv=none; b=npYF0B/I2XPgtiKj/5szBsfKTDIoPoHOfX7yitwOPn4pExyRkpJiyynPrREPx2Ot+oRmXxtPaCEZ03XONuvlyQ8MilZwm8D3OiehkvG5+4KDqEzD10Cuhi6JXeqbhc4HEtELNtJJdQMunK5syayeNHeSjx7KlzDhIjy4EOSMwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058210; c=relaxed/simple;
	bh=bsdXiRg5jpsxkzgX7jVctkBK26SfSXlpC0q/1gug0lU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RgbgeHZqzzaMjbm5jlXE08k+IJxsSzCdP5mKuZj+AOnHVZv/+d95wt9KXIJiEjk8Ox5jucNXbmS7xxphbNnxD71IQT+dry+p+OdNJaVkEayz9SD1xisQHn0L41HqZa3bpFHTE3u/Mj9A59nCOU+j3cCHQ6cRLzxBKimEPvYBgGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LKtWmL/9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b89147cfbso19959745e9.3
        for <linux-pci@vger.kernel.org>; Fri, 05 Sep 2025 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757058206; x=1757663006; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mcFCT9zW4aA60fZ7BLnEw73ykCEqS3kxh9SMpfaPMuI=;
        b=LKtWmL/9mZjRiFHkXt/BZ5UmcXFskWcCR7l1+sdCxkNbNl272KwAOAmrQz0qqLGgEI
         bH1Lwp+/ikays8wJ27SYslmwB7owquYaVQrz45GLQhsTO+4tARW5CUbBfNr2fV/zPQ7i
         F07cL2yhHR/65RI2bQkvt1nujiufYigAUKG1QOo5K7wVJO8QX4Ut6OPR/XUYXFa+UONh
         0NOL87fJdbZk0mOu8VtdnBh09MQhyipIRK8tY6kdSPLWlTPGz7b/97ZB5EGAfDJrAPGp
         ePQH7HdmN+QQey6Iw9A0KA054dC/fIhvmpagN0En+x8XL033nY2Zh1l+YNm82JXk3tYP
         LLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757058206; x=1757663006;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcFCT9zW4aA60fZ7BLnEw73ykCEqS3kxh9SMpfaPMuI=;
        b=rIAF4cgaiGIO1tjUc9pdvjhlvE6iF4uWu2zlxFuGmsasM+9oAj2BsdzX5teS8Dj1Fj
         09NOni8GpygrK/B/yNPzCgPsq2sJx7xD5U/H6RonxGlk+ENtmogLz4cuF2i9Dh1h+JVD
         Gz2r0D72Xk3F47fSuK9E3Mwq0FzOjLYNoMQhhEOL9gx1gMzwSfmxRmftbxJJLlqgTM4C
         RbOj1iE3HEnIyGnGaNmNwtz/BI8mWm83kmOzia6Gs7wwuQ+ZFPDuCxoTWYh2+wLv45El
         571tpanaQBI/jGMF0JCmSK4ReIUqUYZy2ZxP+13XSyFNqnBNDiQm62jBmhscRCX4GkDj
         aNaw==
X-Forwarded-Encrypted: i=1; AJvYcCVdY8+mi10nyOzm0VzluzMQ7XJXrMzqUl6A8BaLO7+/oHPMOAaFr7TTf46/BWI4A2GMF2Hr+WvAdjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHEgGBXKQWYtHGm+nLSyp/JgKBCpg3O/9srtubMxO7H4zJBzy
	JvirxKAXvAgpikOp5bLOaP9EBnpEzaJpWI4PCjq1/3KZbK4ahSZOjnM50Tu5R9OpDF0=
X-Gm-Gg: ASbGncuQRLHhgASbEF7VQvosnl691zH+lzp7PYwD8tjld8fnb+RiiutUPLewrCAAFpW
	yIqjqiXI+18e2usL5zBeV6ib5OU+37KejvCmmRDUZSrsHMRZYzEJ/72wwQ9nzIl0BpSvOd58TV/
	Qh24ODnw0iRjOFLvh8JuKN9ILGBozcLCfGu0p+2sFv4B71YMQcHX9+4D7lSnLCXgZfH7neR3n12
	o2q2KFP4hO/RRwbn4/7a7qenqt3YLoYLTNPMaJKjWp//kW9nUnX6/YFowDv1v50c/KCGQGbBoqU
	aniayAOpNJ/0WiuF1QOX+kW/DlyEpU6H0Cljv5xBwcqh/Jw93G1iYHC5wCflQydt6LVznoPS+1E
	x0Y8mraz9kIPZb3CTuEJVGRaqVGsQM5kH
X-Google-Smtp-Source: AGHT+IElpZ/nNxUYJfXoPhKCLi6yxVHIT8+Ii77o8BHY6J90x7XkcR0yo3B1qo8+VJT1qApCcEJbSw==
X-Received: by 2002:a05:6000:2f81:b0:3e0:b982:ca3d with SMTP id ffacd0b85a97d-3e0b982cdd7mr4374615f8f.59.1757058205661;
        Fri, 05 Sep 2025 00:43:25 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:f203:7a74:e497:6da7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e23d29bb9esm3900639f8f.4.2025.09.05.00.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 00:43:25 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Niklas Cassel <cassel@kernel.org>,  Damien Le Moal <dlemoal@kernel.org>,
  Marek Vasut <marek.vasut+renesas@mailbox.org>,
  linux-pci@vger.kernel.org,  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,  Frank Li
 <Frank.Li@nxp.com>,  Kishon Vijay Abraham I <kishon@kernel.org>,
  Manivannan Sadhasivam <mani@kernel.org>,  Wang Jiang
 <jiangwang@kylinos.cn>,  linux-kernel@vger.kernel.org,
  linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
In-Reply-To: <62584e30-72ab-49df-bfaa-9730679b2dbe@mailbox.org> (Marek Vasut's
	message of "Thu, 4 Sep 2025 23:29:15 +0200")
References: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
	<b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org>
	<aLmGBYOVevP5hH0X@ryzen>
	<62584e30-72ab-49df-bfaa-9730679b2dbe@mailbox.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 05 Sep 2025 09:43:24 +0200
Message-ID: <1jjz2d4a5f.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 04 Sep 2025 at 23:29, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 9/4/25 2:28 PM, Niklas Cassel wrote:
>
> Hello Niklas,
>
> [...]
>
>> pci_epf_alloc_space() works like this:
>> If the user requests a BAR size that is smaller than the fixed-size BAR,
>> it will allocate space matching the fixed-size.
>> As in most cases, having a BAR larger than needed by an EPF driver is
>> still acceptable.
>> However, if the user requests a size larger than the fixed-size BAR,
>> as in your case, we will return an error, as we cannot fulfill the
>> user's request.
>> I don't see any alternative other than your/Damien's proposal above.
>> Unfortunately, all EPF drivers would probably need this same change.
>
> It seems that pci-epf-ntb and pci-epf-vntb only use BAR0 (BAR_CONFIG) and
> BAR0+BAR1 (BAR_CONFIG and BAR_DB) , so those should be OK on this
> controller. NVMe EPF also seems to use only BAR0 and it specifically
> handles fixed size BAR. It seems everything that is in the tree so far
> managed to sidestep hitting fixed-size BAR4 problems on this hardware,
> except for the test driver.

As it stands, a vNTB device needs 3 BARs minimum (CFG, DB and MW). The
NTB one may get away with with 2 BARs, with DB and MW sharing one.

If you referring to Renesas about that BAR4, I did use it for vNTB.
It is indeed not upstream ... yet [1]

I think it is possible to have vNTB on 2 BARs with some tweaks, putting
CFG and DB on the same one.

[1]: https://lore.kernel.org/r/20250702-ntb-rcar-support-v3-2-4268d9c85eb7@baylibre.com

-- 
Jerome

