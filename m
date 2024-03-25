Return-Path: <linux-pci+bounces-5076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3641288A5B9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E529BE1DA9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 13:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C2A1411FC;
	Mon, 25 Mar 2024 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN68QXy2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D31552EE;
	Mon, 25 Mar 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353493; cv=none; b=QqHioXJaCIh0sRIYmd19VNrb/Bit2NfCU/StujBDPh9bH0pVpvABUzj7IOhGD68hH5Qd5pqaaxtYUvl+HW4ITdp/866QF4yuSmDGh+0ASBoSscSMzpJ2CKibKmDYW3Oe3FyaslU7L4Nn3DRweEuqUGZPrVJEbnDNinBtzwA0pmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353493; c=relaxed/simple;
	bh=Sx6G/4KVnSvDZtDlz+a0BNa+uuY8oPOzVjGvI2t2HRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5qOHT2ILgCE20jvJORBTv9XqKallANgc/WwWP3Bz1s7Vcr977QMWDjZO33BlzOp9fzVAVZWqqgMsQkjGxpqfyeCkzNpv4YF5GwIO9fYFHYLZXpKXOuXP8kc6yQvaNc/32Yhsn6KcTpNT74eeeWQnbVZWBm7xOKnr3NFxY0WkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN68QXy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3439C433F1;
	Mon, 25 Mar 2024 07:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711353493;
	bh=Sx6G/4KVnSvDZtDlz+a0BNa+uuY8oPOzVjGvI2t2HRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fN68QXy2XNn0oQMdy9o1qQ06wOMzdYD7GkFIHGy3nqk8FWqWNOE/D8Er+dGxYk0u6
	 Ecc3YFJhiJ42eQws17oQPXIkew9nHnkqbkXj+Nb6xEtXKjU8z9/NBhP/smxortSzVf
	 feU0J61ERibyXprOYdAMETEuUpx5V7ghqKQkRUMbdJX/cANiN0dr4P/LuTOQMuAOXb
	 OlGTQUEtSrDeq0c8q+GlZ7CZ8ND36yz7ei1LJzHNoSx2mQXM76NphM5rt73NdQF9/z
	 gXfkIJgiPxIYFO1oUEn/1L5cdn4xWbigD3xsntiRJRxsiHQ/oatP66O/ZgGk4M6drj
	 r9a9hCKLs3srg==
Message-ID: <44860b09-9714-475d-b562-7b097caecc09@kernel.org>
Date: Mon, 25 Mar 2024 16:58:11 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: Remove pci_enable_device_io()
Content-Language: en-US
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Niklas Cassel <cassel@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-ide@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <370ff61c-1ae0-41ca-95fc-6c45e1b8791d@gmail.com>
 <213ebf62-53a3-42b7-8518-ecd5cd6d6b08@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <213ebf62-53a3-42b7-8518-ecd5cd6d6b08@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/24 02:16, Heiner Kallweit wrote:
> After the last user was removed, remove this PCI core function.
> It's very unlikely that we'll see a new device requiring
> io space access, even though memory space access is supported.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research


