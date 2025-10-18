Return-Path: <linux-pci+bounces-38569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA71BECC66
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 11:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CA494E8878
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 09:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5828B4FA;
	Sat, 18 Oct 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKguXYCC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896D287265
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779374; cv=none; b=n9M+vlD9T6IVKs9XrIO2g7wC8fQe8HoKl1eBZ6mjxGPLhkMtmZYPXBqksllQGQAPGlWM70khENLcrl6vEjZtF9yoY8C7kdYSuh8LU0zbbORBFq4FDcw2cP7ye07Kx3F2jPbvLC2oKIEVZD52N3/KoX9YCWUKXSau64NyN5fECGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779374; c=relaxed/simple;
	bh=TaNfOnzJ37bdn5EXfdLd2aTU48YjWL9W2O/pFm741og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pnyn3gJBF2beaV0TAOosONW/8DQfhoT86xjQuwseBCQn9PaAHyivSsllq/+zAPZVjqKdtJ9XZ/N4x1DiVAjr7paic6q4uUW8hpVD0m3871Huiwzjjp/1dNxxGC7U+9aV6yfCiJbeieTH2DP4mESgk58XKTI6hQ5WvIVjRsizBCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKguXYCC; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c45c11be7so1527258a12.3
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760779370; x=1761384170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TurObsZFmrfjBqIYEt3cBVpmlVp4mzQxFn3YwyTBUP0=;
        b=bKguXYCCOLX+jMX4AR6a2vfDNmZIPJ2zHZMW+NdflzXyraDI4hat8pQl6iz8Qo6zn1
         4Js2W7/9eUFXNeJ8vpejEMyRClMU/p6cGV2kDS1c4yZ3JvFF4OA5zVnFu01fRrdehSwk
         g+B3Aodl5STcsGIey0S4+ZipJtvt1eGlhDbIKqFHhepwahAIzhkQ9qPzpXYA/14olhPO
         RPpSDaeeX4F2TJdSzU8pF6pKKUKHQaoUk/SG03V1kz3bT7WTvqnbbi4dpLdcO6/gVRPj
         P1vaYIkcG/jQ7FP6+YCTiet2l8ip3mwatkbNSAfg529LoAdPdD2cZElDx0IsY8qPqmdx
         aeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760779370; x=1761384170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TurObsZFmrfjBqIYEt3cBVpmlVp4mzQxFn3YwyTBUP0=;
        b=ddza21UMbZXuoJgEBnThjsavB4nLLXnjefnExVz6vyl/JhQ+Xl8tUmU9su+j4PXZuv
         EJOAfj/mJAeJTeTkwPV+JYTeRnD0Pabs/BNYechGWcU6c53t6PPJPWXplsWXwr2/QPag
         1d7n9c2XK+zCd3ZYYGIEoyX0Rt4LBoQR0w0aQs0jawfsVewnD451fEqx4YOBTspHO9qE
         gN1LKQjImV9b5veQahw2BuDU9gvc/RiLMj8njmmNCelWQqXLBY2u+lEWQsG6RkPBnljW
         m5RjUHWHV9cROfLwdq5bv2873t0cNO2hS/9nUYC8gPdC19cbdgyMfJacmuT7uLjzu7Lf
         VmiA==
X-Gm-Message-State: AOJu0YyeSZW+QNPLlRvUtBLufzOyZPvhIwg+6zM5ypmmRuxs1jLo6GAn
	YWw42XLAcEmlnBoqHTipzPFFzELI+w3T0ca4XdYlP3z6Zy37t0Loy1f8bEDvNgntuJ7FFEOVIuL
	f9Xc4zCnC4F7OtIWJ74StmzB4sP5mkC0=
X-Gm-Gg: ASbGnctax4XhpThu6yx3SNlQ+xMmYN7eNEiYp1rOO+OMO/+rAv+bTEsqGcxBkglrLtu
	X4YQP/oyOqbOC5Nz65beqUaNbtCXxf0Ic/6R/KskmmMndmRDbp727xiauRM/QlwSwrbV2SbfYDm
	qVKHJfw77Jksne5jPinLWn8MYcWzxcK17rjzaw8rVo6CRTmz9hHECgGt29YwLjnD+PSKCShjvIA
	/Il9on6aXMsZiykUfF3gZ71TTBx2oK8rOJsIcp2g8+PQKM/NnbRk49GhinM5mafxQTYyg==
X-Google-Smtp-Source: AGHT+IHw19pBZ9IqmqMp9HxxNmCsj695WdYgJZRejOrWZTvR3/bpEeF5am+muoYu9/EE8QnKVNq6O32MbmibLE6n32Q=
X-Received: by 2002:a05:6402:d09:b0:633:7b1e:9aa3 with SMTP id
 4fb4d7f45d1cf-63c1f6f6269mr5785386a12.34.1760779370419; Sat, 18 Oct 2025
 02:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014113234.44418-2-linux.amoon@gmail.com> <a2cefc72-de44-4a23-92d2-44b58c8c13fe@web.de>
In-Reply-To: <a2cefc72-de44-4a23-92d2-44b58c8c13fe@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 18 Oct 2025 14:52:34 +0530
X-Gm-Features: AS18NWDbaJ8hdNv-j0Yxl1ICNkckxlgqQRK21f2Q02tESiNZuDiGqp2OynZDz4k
Message-ID: <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: j721e: Propagate dev_err_probe return value
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

Thanks for the review comments.
On Sat, 18 Oct 2025 at 14:26, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > Ensure that the return value from dev_err_probe() is consistently assigned
> > back to ret in all error paths within j721e_pcie_probe(). This ensures
> > the original error code are propagation for debugging.
>
> I find the change description improvable.
>
Ok, I will update this once I get some more feedback on the changes.

>
> I propose to take another source code transformation approach better into account.
> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/core.c#L5031-L5075
>
> Example:
> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/pci/controller/cadence/pci-j721e.c#L444-L636
>
>         ret = dev_err_probe(dev, cdns_pcie_init_phy(dev, cdns_pcie), "Failed to init phy\n");
>         if (ret)
>                 goto err_get_sync;
>
No, the correct code ensures that dev_err_probe() is only called when
an actual error
has occurred, providing a clear and accurate log entry. For deferred
probe (-EPROBE_DEFER),
it will correctly log at a debug level, as intended for that scenario.
For other errors,
it will provide a standard error message.
>
> How do you think about to achieve such a source code variant also with the help of
> the semantic patch language (Coccinelle software)?
I do not have any idea about this.
>
> Regards,
> Markus
Thanks
-Anand

