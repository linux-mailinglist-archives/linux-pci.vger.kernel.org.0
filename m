Return-Path: <linux-pci+bounces-26622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A66A99B7A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 00:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F3917A03D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 22:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4D01EF099;
	Wed, 23 Apr 2025 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8hgffYk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF6E1DE4E6
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446988; cv=none; b=OXlT84LWmrMY+0zdGGst+CvUAakBp58atRLybvxMAk9D1lb8XJKFM7zhQeaxoQVV8ldDqnQy5y9IU+jyqEHv5iQTULwO2K9GXdPs0T/yPTJsjdXeKtYSET0cYbB2bkvYqNqLNKoYN4vvTrZI8rhvtN+d/G1YWUBjOuw+eExDtBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446988; c=relaxed/simple;
	bh=3Za4OyAWmGdEWCOX4stfrH+a41PXHF4wT1Je5Vv67xI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jCAfmlduGP2wWLU0AO+0R+s/V8ebleTHEc5/nO1DNDZ2/Mfw4l9on9gGFt/6AHVhNdgWZ1TeFEfjtzeSBeYWFe01I13PQXa26+zQx+Puk71ER9sX2r1YCJ51BP/mU6r/HHcarsytxnrovmMG0EeJ2I7FLnGjq45xxNfN1BI9v+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8hgffYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8953FC4CEE2;
	Wed, 23 Apr 2025 22:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745446988;
	bh=3Za4OyAWmGdEWCOX4stfrH+a41PXHF4wT1Je5Vv67xI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=d8hgffYkqMNfZPLoRlARFBtp/uxhjXSEFf0CB7VzRDY/yxo1x8nn5j2DVA+S9SYhL
	 UxEqjM1NDE1g2GYKoBe7IEFa5Bd1Z77dtqykObuk0x+Dr7Nub+LypRYva5K9ZsfYLg
	 KcF2rvAP3ICt8dy7Smx8lezboz4jLUvDxSLCS6j/Xh8WG0EGVcYK7LXPIPPyVk9ZTk
	 YlkTCLVQKKAKbQNoTuqhLezHX08OG06kEFg/d6M2xPTk8OvTcdp4qGuv0KXrNpTFzj
	 9ke3SQpmsM0XloFOYL9Uo/5xQIGDZA8A/+lXE+pApGAmpHkQbMdpdfh7t+F0SkqVD7
	 Rjb81h1hpqatQ==
Date: Thu, 24 Apr 2025 00:23:05 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, bhelgaas@google.com,
 kw@linux.com, Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RESEND=5D_misc=3A?=
 =?US-ASCII?Q?_pci=5Fendpoint=5Ftest=3A_Defe?=
 =?US-ASCII?Q?r_IRQ_allocation_until_ioctl=28PCITEST=5FSET=5FIRQTYPE=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250423221920.GA460034@bhelgaas>
References: <20250423221920.GA460034@bhelgaas>
Message-ID: <BECE293B-614E-45F4-8B15-9D29018FD47B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 24 April 2025 00:19:20 CEST, Bjorn Helgaas <helgaas@kernel=2Eorg> wrote=
:
>>=20
>> For those platforms, without this patch, you will get:
>>   pci-endpoint-test 0001:01:00=2E0: Invalid IRQ type selected
>>   pci-endpoint-test 0001:01:00=2E0: probe with driver pci-endpoint-test=
 failed with error -22
>
>So I guess this means it's "only" the host side
>pci_endpoint_test_driver that won't probe, and the problem only
>happens on the host controllers listed above or controllers with
>programmable Vendor/Device ID that are set to match one of these?

Correct!


Kind regards,
Niklas

