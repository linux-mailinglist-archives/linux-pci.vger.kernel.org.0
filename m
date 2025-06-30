Return-Path: <linux-pci+bounces-31097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E0AEE625
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 19:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D7E189A211
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 17:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A47928CF50;
	Mon, 30 Jun 2025 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikdGqFVC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0025235055;
	Mon, 30 Jun 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306115; cv=none; b=YYwbeSFDwF0P5EFLA79neR7QAV8fddFayXpoOyy8WwTK26wcdaWeyZYZBWO3A+WKjDYbMBz6IF9v8LCN+YSj+PJ2g1/URUDlZ1WKOXefEX7OMK/DDEwgravfAxWjaw82gjfQmg5qyGJdQpKgIP5ztqU6wRjHidol0hitE5bdqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306115; c=relaxed/simple;
	bh=xCP0lSFxIcMApdmiCN1IO19eX/+PljO+U2Ru8kuP1/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcqwN14HEYg92VvRJ0dAty3rYr7HxDiOWI3deNjFOWu+WByhYm7+M1teaSiCu4u6bVTv7NQIYjs1VenfMuj+ECE6iio59d3Ic9kY3UkJtRZMlz4z+BUaMZmDlrZBpu6qmBOqid3UGUH8QdN3MPkXsbYu8z8SCek9EScOIiSZSgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikdGqFVC; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d3f5796755so448099385a.1;
        Mon, 30 Jun 2025 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751306113; x=1751910913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TkbKDizxju3W+51KZwQ3Fxa7XNUAV9NHwEQ1ocZXOb4=;
        b=ikdGqFVCvD45KJtz/I1mNsWLKvaiRJVKLbo2/74k3g5EBsemP6nmOnFapjIGQIWz5I
         TXHoGtdNY7sA6qc4aL7PHpOog9qRHXIO1NxOjlMKWvSO8gls5DQGIz3pzOzcvznctpkP
         SZ5dYkp/cs+CWO+S2c4wFsfLtRio7g9dUxLNv4pQd5YLnEj4RpFQJzr6wwng0AzLh+Qp
         ddwjYn9niA8Pwh6WRmUSoIK9q01w4h3hRvig1APBB5n7oTYWsg86gURg91wOt2nXroYm
         fio5LTyUVqs+6jKDjK/txXYfp2plqZivgr//KThc+F1nGU/YqWnBXbt/iLNVrvN5XIkQ
         PFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751306113; x=1751910913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkbKDizxju3W+51KZwQ3Fxa7XNUAV9NHwEQ1ocZXOb4=;
        b=SW++OdUJoNG0VV0j30oG08Pr7C12nlyYH5FwM/K4c/ANsfncj7HnlRPwlvbM+6p1U/
         a5rS654EYcexTxF4IFMHMJO3eeHuqgsUcx2cH+UyesR8lq15M765jgcoHpk6GWogWx8H
         KqpQilYDcgP+rxNNYuKy+LXZO05Npc7ultJE/Zco9iReJXwLdRcCmZmNKqsDocEBNyx+
         uA+h4Jb9ilTGgExBit4vE3u132qFVZSvcpvGKArKN0X38UAOVbq2Fm2iiRIJXg/e0pNN
         A4uh6Mv2MzsrIeOVEN0KGFLX82LnOVL88mWGxYgs9unFDx/N9Y0Pzux6ANozzQNR60Vf
         NttA==
X-Forwarded-Encrypted: i=1; AJvYcCWIR6x8aa86DUCxNf9uzTdT8CYgMSN0tNB62wkkh9MA7wjRMQODLX0cfzWuNcAf9/3fccXTGfsViY1C@vger.kernel.org, AJvYcCXuCoRYTTmENLlNAD/LYXE8hjp4qnpUtoa4+2liHtBqqkqO0FQpuCvCKHCQLSbDFZjXoeUIAzG3rJ8mJvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz40dIoW/OvhLfZOoWhDef6AedOo1lFCaKnkze5t3ocxtnfd/6L
	/ij6mH8L6ReJ5W2icBP/vKVPY/Q6rx6KjLREGOFZPm8FqU1R/earpJLf
X-Gm-Gg: ASbGncsIrOHJ6f7w427T72Lzx6pJu/zgAGI5OY8BUCT2cPKx9zkmatr/c1Ulm5IxckU
	siyx1FUE8CnlxTA+8vncL6AwEAlhlM0Vd6Ab8nf3FkQ8J/3rpZtHUGj1nfoq8gb60o1PmbNeE2S
	zQ9QDzFXPZdQQ2pDqdKwQJVfyapmQ97qtVB1J0Po9LnyBHRAd/sTyj7qrLvOrUtXjOMRQgJgTZ3
	Lln5T9DYoNXixn1X/hCwuIN/b6aeK8MGMlDyUk3484b388BKHwlKhPd9YZedMT08vwSKNh35AD4
	f0u8QAai6/H+DOiYV3gjFAeKwdCX5i2Yhrs/Mb5AVXfxCr5UtQ==
X-Google-Smtp-Source: AGHT+IEAoLv3ZFdFWjd7lAICC4bbFV6sU3+PxQlEK6DUAJNkCBCFRSmZ508WVU4rao0shvvKBCho+w==
X-Received: by 2002:a05:620a:1993:b0:7d4:4d55:98f9 with SMTP id af79cd13be357-7d44d55b1f9mr1237496485a.28.1751306112549;
        Mon, 30 Jun 2025 10:55:12 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d443203279sm636637885a.54.2025.06.30.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:55:12 -0700 (PDT)
Date: Mon, 30 Jun 2025 14:55:05 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] phy: rockchip-pcie: Enable all four lanes if
 required
Message-ID: <aGLPeZn9ZSw3FurH@geday>
References: <cover.1751200382.git.geraldogabriel@gmail.com>
 <b203b067e369411b029039f96cfeae300874b4c7.1751200382.git.geraldogabriel@gmail.com>
 <2affed16-f3c4-47d3-9ca6-e4f48e875367@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2affed16-f3c4-47d3-9ca6-e4f48e875367@arm.com>

On Mon, Jun 30, 2025 at 02:48:25PM +0100, Robin Murphy wrote:
> On 29/06/2025 9:58 pm, Geraldo Nascimento wrote:
> > Current code enables only Lane 0 because pwr_cnt will be incremented on
> > first call to the function. Let's reorder the enablement code to enable
> > all 4 lanes through GRF.
> 
> As usual the TRM isn't very clear, but the way it describes the 
> GRF_SOC_CON_5_PCIE bits does suggest they're driving external input 
> signals of the phy block, so it seems reasonable that it could be OK to 
> update the register itself without worrying about releasing the phy from 
> reset first. In that case I'd agree this seems the cleanest fix, and if 
> it works empirically then I think I'm now sufficiently convinced too;
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Hi Robin and Neil,

Thank you both for the positive reviews and the effort.

I must admit however that it looks like this patch was lifted verbatim
from Armbian and I'm missing the Signed-off-by from the original author.

As Robin may attest, I initially started by blindingly enabling all
lanes which, of course, is no good. I tried a suggestion by Robin which
did not work, and eventually settled on this Armbian solution, which at
least has got some battle-testing.

I already contacted Valmintas Paliksa, the original author of the patch,
and asked permission to use his Signed-off-by. I'm aware I could probably
use the Signed-off-by without strict permission, but it does not feel
right to me.

Thanks,
Geraldo Nascimento

