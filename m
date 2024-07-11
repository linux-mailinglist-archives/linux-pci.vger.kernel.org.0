Return-Path: <linux-pci+bounces-10170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7700292ED30
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 18:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D65B22265
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD3816D9C4;
	Thu, 11 Jul 2024 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/ITI5ct"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72B16D4EF;
	Thu, 11 Jul 2024 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716985; cv=none; b=Rhgbgp9Y+H5q2Rt4LbB9B421kjbCB2B8aVfyrZblxmBHvBtLg6uOhG92IHOUylGzxTI1PLUNBW35mpFBdgIDiTt7ssHpVqnblqqVFPnNr7HYSJPQ/hlQd6KcpxjoU0dTpsYXhPTD/vKgSaCqeqo6wWLeHnr1U7e5iS8tGTckMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716985; c=relaxed/simple;
	bh=Srjffhq/QEL0D7rE/5f2aF0wpNTGUpr1FwqNehchXIk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iouaA9ULWM9AKpf0kKa7ONPDVR/TwyT0y2Rc+5flMsTgkZ2LxoCmlN/xFNUQIcXOLM+v10uA7PD6ftcUEz0WQm8e76TH9+8spIyfepbo1RpASNv9Pi1K/FqDF6xItWkvGfPnouiv0p4un2PISbizEctEhtU3pRuH8IhGUvm5XXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/ITI5ct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D3EC116B1;
	Thu, 11 Jul 2024 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720716985;
	bh=Srjffhq/QEL0D7rE/5f2aF0wpNTGUpr1FwqNehchXIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D/ITI5ctT+p8Atevf5B6g/Ceu8qZ3fwMQ7EDLaaeC8WeeMOO0D44puOPfPD7v8K7g
	 5ULh4H9RpT1tx0fjIQdusPInxMlnZAb4eHJK7SpkKi1gDGYLjYO9Ym+sUEuRZsj+KU
	 i6JuclcW/ZsllAv29Nfc0Qd06A0dS+bH5HHsuvEr5OZsRov1QvkaKd1wFQYcMGPuB0
	 JJr29Fz992iKD1lBp6Oe9Y4qONPZ9L995ub7Qs0NGFHw9kCttEtBbcuz8Ir0iay1qc
	 SD6AJyThQrEiXouo5hsOhC7+MC7Nhywg+SVT3gknNHaSEfPRKYB75Ec64izEkjQBwU
	 AKV4mNbEZuE+w==
Date: Thu, 11 Jul 2024 11:56:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH v6 4/5] PCI: epf-mhi: Add wakeup host op
Message-ID: <20240711165623.GA287126@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-wakeup_host-v6-4-ef00f31ea38d@quicinc.com>

On Wed, Jul 10, 2024 at 04:46:11PM +0530, Krishna chaitanya chundru wrote:
> Add wakeup host op for MHI EPF.
> If the D-state is in D3cold toggle wake signal, otherwise send PME.

Feels racy.  Maybe it doesn't matter?  I guess it's unavoidable that
we could be in D3hot, commit to sending PME, and then main power goes
away so we're now in D3cold and the PME is not delivered?  Is there a
way to recover from that?

s/D-state is in D3cold/D-state is D3cold/
s/toggle wake/assert WAKE#/

Rewrap into single paragraph or add blank line between.

