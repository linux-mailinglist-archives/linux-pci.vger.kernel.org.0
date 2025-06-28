Return-Path: <linux-pci+bounces-30995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D771AEC6D3
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 13:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E99D170478
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718FA245016;
	Sat, 28 Jun 2025 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpT5Ofc+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480BB23ED75;
	Sat, 28 Jun 2025 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751111839; cv=none; b=VzZ+eeQqLXpDVjpX3I4hHK/yeolEqhbwO3l85V0g+m3Q2rOFr8VEUTNN913IHkBQtu5VO7xcadqlWK3zNsdbQVozP8rPaRES1gyEmsUnq62ellEo1RAJrd5Xqb5Q/J8pav2sBGajLAw6KdhuIcDLW80rn/IC0MvOI/eSFnC1Z94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751111839; c=relaxed/simple;
	bh=Is2yPmWDs+etT8g5JmCqXbnzcsJsD7GJL/46/JrU1PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHyyibiskyiOH1mAFqFBS7zMh0zp4GpIAEIj4/GQUpZ8L6l3h8z+N48qiBqbuk36F0twLwSukGfac9SHbiK+5v01SdaMJBANNgeq2F+dm/KiDJv3aP774c2rCMTpTuXOlzg12eI3KkeIVZ3yhEpqi1ehBAi4rI2x9Rj3I8PZWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpT5Ofc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61601C4CEEA;
	Sat, 28 Jun 2025 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751111838;
	bh=Is2yPmWDs+etT8g5JmCqXbnzcsJsD7GJL/46/JrU1PI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HpT5Ofc+CtBERYDnttE3XdOJx/nHIGFXojQTp/njEVdJ/aFPlfmgDOPVdJcB5Jz9O
	 O3y7G8QWfSUXrWi1T+OmY97IqcY3D0XEIQhvxGWl2DVbt+1yBlefptMIGYis2y27sF
	 KaGZIH/bbfjUJ0diFRDF0W+hdKNhjYJFHo8+zMyW9RUfQ/+qECtdBzs5YDHemJRJnp
	 vjDRcT3PGzz9Svi9x7fMO+OiJIhGTkFSN6YYV9S772BDlaULEjmUMQXTnimv3UXnWY
	 Sf7hvTOcSf8UkaVSYbnFcxeoPofl7Bux0WLaWJ+EC48mou5K92cpKOxAf+LZ09csk9
	 XINwINhd5h2YQ==
Message-ID: <98ade377-2975-4767-b9f5-02d77141bfc3@kernel.org>
Date: Sat, 28 Jun 2025 13:57:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: fix uaf for resource file
To: zhangjian <zhangjian496@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: lossin@kernel.org, aliceryhl@google.com, simona.vetter@ffwll.ch,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250629030547.1073425-1-zhangjian496@huawei.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250629030547.1073425-1-zhangjian496@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/29/25 5:05 AM, zhangjian wrote:
> concurrently creating attr files may cause uaf. We meet this in concurrently
> plug and unplug network card.

Not exactly sure how you got to this specific list of recipients, but you should
also send the patch to Bjorn Helgaas <bhelgaas@google.com>.

Otherwise, please use scripts/get_maintainer.pl to find the list of required
recipients.

