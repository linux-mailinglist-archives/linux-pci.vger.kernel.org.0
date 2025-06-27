Return-Path: <linux-pci+bounces-30900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A20AEAFCB
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 09:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C9217539C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 07:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2912219EAD;
	Fri, 27 Jun 2025 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQG24HIg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04641922DE;
	Fri, 27 Jun 2025 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008086; cv=none; b=sZFCBtH86wJVhk2J9zPwdUBWq6vuTZqyjuNsJs0U/64gPzIvd/fbmoBs774Bii/JZVJKernZhwlaRFpld6Heo1dlhj4bh04Hy2v/xXPN/Fd/etb5o4ucV6nLKeHX+e/zIrZ+Nex3HN2UzKDH8wh15Jp2bNEBtt+/GIbOiEqHx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008086; c=relaxed/simple;
	bh=qPIY1fmZkbzHrI9oc6GJqjDbb45CZC+fXwI9YDyLsLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK3jf98MkXcid4eimdaW/0CxYf6wVrW0ckTQbJA3r9WYyVdIvZ5pvzFZxuB7uU3ptJ8CtLeETJlCfANX3WAreVJ39uUuAwxk9xAhAefMpHuFFt0BEKZCik/W/bQS8m2QmBISDDopFkCHBNSCHXDWVNIgGlWXYlS0rVa82+VkIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQG24HIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8CEC4CEE3;
	Fri, 27 Jun 2025 07:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751008086;
	bh=qPIY1fmZkbzHrI9oc6GJqjDbb45CZC+fXwI9YDyLsLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQG24HIgwtX2nEJAbCbGrkSmGsCg6MTegv2UU06UpctZ0nF8cdqxoC5fUh7Q23Fdj
	 fVxDDiMgeIrbDcyh2YPjXwMPqDEVZ9C8Da35MB2dq8B4ZcjKbX9eDn1b6vqV1tE0ng
	 QAh0rc/4Gj9l92MKqP+oeaMaVrxRBK9zg3JtkSTsWjT/EvAHWktswNi2M3cd9b8X+/
	 QR5ngwsUx3/2CvYv4Acv2YkuMwyuWgwKPqKgK4I/dUK9MQJZ8+/4rrekQ1f7DP6ReO
	 E0ko7WWE086WrB9noli8lAKjKEfAG3c9F/Vu0frE+WAoSddoBFepQPdHTDqpZ+6/6z
	 kO9CeZxF/ywEw==
Date: Fri, 27 Jun 2025 09:08:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
	johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org, neil.armstrong@linaro.org, 
	abel.vesa@linaro.org, kw@linux.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com, 
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
Message-ID: <20250627-flashy-flounder-of-hurricane-d4c8d8@krzk-bin>
References: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
 <20250625090048.624399-3-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625090048.624399-3-quic_ziyuzhan@quicinc.com>

On Wed, Jun 25, 2025 at 05:00:46PM +0800, Ziyue Zhang wrote:
> Each PCIe controller on sa8775p includes 'link_down'reset on hardware,
> document it.

This is an ABI break, so you need to clearly express it and explain the
impact. Following previous Qualcomm feedback we cannot give review to
imperfect commits, because this would be precedent to accept such
imperfectness in the future.

Therefore follow all standard rules about ABI.

Best regards,
Krzysztof


