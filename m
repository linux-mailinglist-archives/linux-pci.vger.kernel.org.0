Return-Path: <linux-pci+bounces-11975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D73795A3F3
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 19:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF40C2823CE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF0B16C685;
	Wed, 21 Aug 2024 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFpjcsqa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC7E13BAC2;
	Wed, 21 Aug 2024 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261663; cv=none; b=ex9mpYqLopoXSmGu0Tv87FqkNo27q6YyMHA8VhyrCFaNWxEow/bwgMEZO6ZC3YFnEfv91ks/GSCy7PWahVXaSbnZSPm48ykU8s+Xjvj0bx9c5q+MQKlZWg4w0PQaRxxJTUi1vkyZ4fwKCsxI5+vE7KP9rz03tZa1i7jdN/SoAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261663; c=relaxed/simple;
	bh=ZL0U+xlYVPiwePIng7QOJuSvopm4n2kViEI9Q+mCpCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XFYK6bd4Rfz6Wq2JiYLVYHdNWLhR/dbB2RXxEBUNGoCrMBhp3QyOZFvqNS1RFpk7w6zyHqCxWxRhc5/HdDsu/IiD091uncsM3qG+Nh4u9Y860kmn9FurTa3pwNpp8YvqHFtKvwv0U32EBRRxf61drgh8+qjtJr/4vaBEcBYIin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFpjcsqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9443C4AF09;
	Wed, 21 Aug 2024 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724261663;
	bh=ZL0U+xlYVPiwePIng7QOJuSvopm4n2kViEI9Q+mCpCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZFpjcsqa+0m3wb14Auqn4VS9qS2uJfNx1B/0L44mCRL22IaNPBkfUQ2KQLf3Z31M/
	 HNMH09OXdmAQwmHXlyBau5fCszXI9JwuzFHEt4W7z98evPHV7HImavOaxYhlSl/Uhe
	 U01oND75xskUA+xWiEAhDH2Ri9RDbYyW+FpDUluzuf2alFg6l7xXP0TF+A1vw9qhum
	 i6Gq5Xwy8O9hr/edugDtX0w9lEUCqCK2ILnmZTL9uSl55Yu0MJXu3BC/rxSPyLOAWZ
	 EZDbWKVenC6t2sbkXIG7md4ZkhetNr4YZY1z3Fh/KaVdTP0CuMeCwu+2cS+yUDLnRt
	 AKCjrqCdBWypw==
Date: Wed, 21 Aug 2024 12:34:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/3] PCI: qcom: Add equalization settings for 16 GT/s
Message-ID: <20240821173421.GA260420@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821170917.21018-3-quic_schintav@quicinc.com>

On Wed, Aug 21, 2024 at 10:08:43AM -0700, Shashank Babu Chinta Venkata wrote:
> During high data transmission rates such as 16 GT/s , there is an

s/ ,/,/

> increased risk of signal loss due to poor channel quality and
> interference. This can impact receiver's ability to capture signals
> accurately. Hence, signal compensation is achieved through appropriate
> lane equalization settings at both transmitter and receiver. This will
> result in increased PCIe signal strength.

