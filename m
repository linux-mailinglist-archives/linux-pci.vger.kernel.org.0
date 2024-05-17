Return-Path: <linux-pci+bounces-7617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC0A8C85AB
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02955287466
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563603D541;
	Fri, 17 May 2024 11:27:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBDD3C489;
	Fri, 17 May 2024 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945258; cv=none; b=QfTQrvS3B4NC8IMYvMnXsjnPzISklBpKA88YobIKGi5GxycR/TU+OfhUN0P82/HVaBtQNCe7qmerTDOtHIXH1KezZDFoX67JEhB0dDNGZZbj0uBJt0vNiJsYeOy0yvtOc4JctFJxmsD7xt5jkCd6OjR0lljB40ZO81J61WAH8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945258; c=relaxed/simple;
	bh=607rlmrokgIRlxHBXmc+PYlNv3Rhu+Wg+J+WezFtGPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvF7NGbbUQ7WIyGeJihE0hO7Z2D5cLNxMw79EfTL6gH9c1GY/lcElGTXpeyYHMvJlv7yM9kl7rVUbFAhcIjPZiOnWc1nk6T0ftfTLNM3FFnMa/Jf56kpMwVXE5Xi3IHTvu6isyweUIDxBVGNcFInq7szmYcRgY11WHv9c0OXgAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ecd3867556so5511705ad.0;
        Fri, 17 May 2024 04:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715945256; x=1716550056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNbDqqCZmMiycWkhsVWXK1N4GybBuEHzc7K4hpEAXZE=;
        b=lu0zew1QSrxj59yklUNjjNvMhMIFpCEzMAu9mQtK8IpV517Zow/c/OrKWUdhF/V94n
         JnPJVOzOYnD6bijm9ZbfkjmBrVieEJa5h0qr0T+LMfzqSynV3SPdAmSiPTgkLB7I/KvQ
         xucS8Bg1yzKdNV8LpgoTPSaXMLBy1uPHdgIwrkdViHU7KpJfinATHaZg1R0MrNvqkmaF
         +SzCTPc75WUjnc2caPsmDLkauGQm+Q3Yuq3DAUosrIL7P2C8UiFjThEhCnXDSUoPAmSi
         JH5nd38RgEYChNGAudvHbn4vQl2j8wrCHPHSp3xzwbehr78JO6I9L1rb1KOdDAYEFWiV
         FgkA==
X-Forwarded-Encrypted: i=1; AJvYcCWI2z3dJI9mAXFFWJy0ZdcKT/ZirJR8GsQifDji+Re4krJSd/m4rudwpAq5jz3Wct0l1ZKhi/TmXWfvlqxQe+NBubYV3VWWQk3dxjMHJk67UZk=
X-Gm-Message-State: AOJu0YwBHyn1NfpHUoTZnwOA8K8fwoxM3RHDHEIaAohK8t38f7q017zV
	aeu1XU/Jm0IjGh1DfdYkva1VaiJTGwSAAr5Q9nH1HPoOwvd5PnbI
X-Google-Smtp-Source: AGHT+IGxROLxzh+/1RI/kwpleAp3jL3W+yiAQVOPsPoUJ+1G+M7qN5cYT6t1bW1mWzHq+9nmGBW/vA==
X-Received: by 2002:a17:902:e80b:b0:1eb:5323:c320 with SMTP id d9443c01a7336-1ef4406046fmr292403865ad.56.1715945256065;
        Fri, 17 May 2024 04:27:36 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada3efsm155625185ad.114.2024.05.17.04.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:27:35 -0700 (PDT)
Date: Fri, 17 May 2024 20:27:34 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Demote WARN() to dev_warn_ratelimited() in
 rcar_pcie_wakeup()
Message-ID: <20240517112734.GX202520@rocinante>
References: <20240511235513.77301-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511235513.77301-1-marek.vasut+renesas@mailbox.org>

Hello,

> Avoid large backtrace, it is sufficient to warn the user that there has
> been a link problem. Either the link has failed and the system is in need
> of maintenance, or the link continues to work and user has been informed.
> The message from the warning can be looked up in the sources.
> 
> This makes an actual link issue less verbose.
> 
> First of all, this controller has a limitation in that the controller
> driver has to assist the hardware with transition to L1 link state by
> writing L1IATN to PMCTRL register, the L1 and L0 link state switching
> is not fully automatic on this controller.
> 
> In case of an ASMedia ASM1062 PCIe SATA controller which does not support
> ASPM, on entry to suspend or during platform pm_test, the SATA controller
> enters D3hot state and the link enters L1 state. If the SATA controller
> wakes up before rcar_pcie_wakeup() was called and returns to D0, the link
> returns to L0 before the controller driver even started its transition to
> L1 link state. At this point, the SATA controller did send an PM_ENTER_L1
> DLLP to the PCIe controller and the PCIe controller received it, and the
> PCIe controller did set PMSR PMEL1RX bit.
> 
> Once rcar_pcie_wakeup() is called, if the link is already back in L0 state
> and PMEL1RX bit is set, the controller driver has no way to determine if
> it should perform the link transition to L1 state, or treat the link as if
> it is in L0 state. Currently the driver attempts to perform the transition
> to L1 link state unconditionally, which in this specific case fails with a
> PMSR L1FAEG poll timeout, however the link still works as it is already
> back in L0 state.
> 
> Reduce this warning verbosity. In case the link is really broken, the
> rcar_pcie_config_access() would fail, otherwise it will succeed and any
> system with this controller and ASM1062 can suspend without generating
> a backtrace.

Applied to controller/rcar, thank you!

[1/1] PCI: rcar: Demote WARN() to dev_warn_ratelimited() in rcar_pcie_wakeup()
      https://git.kernel.org/pci/pci/c/a37647d5639b

	Krzysztof

