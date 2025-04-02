Return-Path: <linux-pci+bounces-25193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB882A79364
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 18:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A152116ABD7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 16:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B3418DB3D;
	Wed,  2 Apr 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJVnjbaD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19111136E37;
	Wed,  2 Apr 2025 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612202; cv=none; b=qg7E/Q16wdXKEvnFo/5Kk8bHu70P9McPuiNQ/waeQZR0ye5d9+kQKjR0gVXD4612YZbPEIacskEdOfDARf3hSXzmUFh4rF1UTQjWWg93irQ/TsvpZaEX+A5MrDqE+eJVqMPgH/NZ46Qy7fUu6a+9HvoOUvne+uCCf7rmYssY4aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612202; c=relaxed/simple;
	bh=P8dyXi8dy6y0x5+ppJybNb0wE0r6kbKjHxaym0EfjEc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AIUL5WEZTkfWrT9v/YG+h/bfULm6/E9/+X7aUIXxIf2uHKQjnZVRiCfW9eGATWS8wUdqKKOW6j/u2FJshH1fPqaOF2BsHUScavkxI5n4jULK0uAYuExSalML6rLvEdheepFZHSKjo796i7KIPJ7LKb7yaWoI398pg7COzstTkr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJVnjbaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92DFC4CEE5;
	Wed,  2 Apr 2025 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743612201;
	bh=P8dyXi8dy6y0x5+ppJybNb0wE0r6kbKjHxaym0EfjEc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BJVnjbaDyJjjE31qW4UcBKd4wQoAySxgLETYb0Uwmal+5urLXpSi0oUSTCs4cCRwZ
	 4A3U9i+lXdojF9SSgOyjPXsMkJ5twicrpT3c7axoYGYQrM7Up1em/GeqnvJX4ywGd2
	 wsnfHYbNfaR52++1zAlFkEGhh6sNs5r7QPgzFz/Z+Lmz2lgufOtWIE4qRTt187xQeH
	 Grsc7jbenYQR4L5trBhg/ghCToDwowshiwJz2BWDeF+FNhZPKNMOJieySoyWNCO7hU
	 cWqAkazKMyvyQvzmVOvWa/yerAwI6BuKmMTKRcD43r8+eTxWj9UG+cLMTg59tEqpy5
	 00na9+cFY3YAg==
Date: Wed, 02 Apr 2025 18:43:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Set intx_capable in epc_features
User-Agent: K-9 Mail for Android
In-Reply-To: <rkdzsql5vqk36wea5mvr34jz5t32jwleep7brigrgkuir3jlxy@qcbdb3pty7iq>
References: <20250402091628.4041790-2-cassel@kernel.org> <rkdzsql5vqk36wea5mvr34jz5t32jwleep7brigrgkuir3jlxy@qcbdb3pty7iq>
Message-ID: <755F7184-5076-40D6-9C74-FC1721BED16B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 2 April 2025 18:34:28 CEST, Manivannan Sadhasivam <manivannan=2Esadhasi=
vam@linaro=2Eorg> wrote:
>On Wed, Apr 02, 2025 at 11:16:28AM +0200, Niklas Cassel wrote:
>> While I do not have the technical reference manuals, the qcom-ep
>> maintainer assures me that all compatibles support generating INTx IRQs=
=2E
>>=20
>
>Yes, all Qcom EP controllers do support INTx=2E
>
>> Thus, set intx_capable to true in epc_features=2E
>>=20
>
>Hmm, this, I do not want to do atm=2E Qcom endpoints cannot raise INTx du=
e to lack
>of the driver support=2E So setting this flag would imply that the INTx i=
s
>functionally supported by the endpoint, but it is not=2E
>
>Atleast, 'pci_epc_features' is not a devicetree configuration, that it ha=
s to
>match what the hw supports instead of the driver support availability :)

Ok, I misunderstood then=2E

Let's just drop this patch=2E



Kind regards,
Niklas

