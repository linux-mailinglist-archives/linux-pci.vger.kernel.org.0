Return-Path: <linux-pci+bounces-20402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC3AA1D66D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 14:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D653A7547
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9922A1FECDF;
	Mon, 27 Jan 2025 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="UycoNxHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8971FF1D2;
	Mon, 27 Jan 2025 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983659; cv=none; b=mVv0CN9VvOlhCQ4RcczL6yRt3/8bLL+LRJx1x5mMZ6Jzx+oU+3QsIEXKgn+P2D/glC4BMPh9rWUL7Fet1KCcs/GfNEqPm3qsk6jFlnIWXRhBmQejSIhvQ/ZrY/qBhGarRJ6ze54uHjTvEUEMU/mf1XsF8ciyP/EsDpTONW0ySMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983659; c=relaxed/simple;
	bh=+TD34DWlVeBCF9TxVvyZW2tTKif6D+3h44HP29cmfTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VuX/OElbo5/o9Oq69r4HImG2xafoENIBkP5Uar0ZAgE1E66NWhOiNONnesOW1MDP8/yX6/Eh5P0uMz0fs8/UPmaWgCSuT2V6NPYlPcc+ju8IkGtf9wFLDHbw9//SptEy3cHQZnTn9FvlTUDS9pX2T5ABJYRmCme2DcCl86aNHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=UycoNxHs; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1737983654; x=1738588454; i=deller@gmx.de;
	bh=AmpspTX3UMr/IyJbB7KVzURTuFyCrFrpn2FmMhLiZn0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UycoNxHsS4wj8TCsG4FmIW9/Vr34Do2pz/2p+ia4YEO/FMwsYrbHrWtlbgMIn6uY
	 3uf83MW1ZeT9HpwxXUFm9IeZyLuKYkvP+EefnuCl+JRYLf2GhOL4lITodG+C8778p
	 b6rdRTWtMm6yBYNBsJEAxnB17RFSXbxYs05gyQjVhJoJAPHdNeo4DDFYKmFQctrWP
	 T6je1JesLK6W26gVbEsc0nkZLGz+21rsnqrmJMyrkabax97cZC/DJ9Ir39KsiYFoC
	 dWcqXkkoAU75Cd/MI0lKE6lrRE0kwEZs90Y+/zXf49sEXghwR1Ec8jwlepp+S/EOB
	 /BqkiwZ7q/DHGlHxfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNtF-1tCjI847qP-00hFk7; Mon, 27
 Jan 2025 14:14:14 +0100
Message-ID: <ac39e075-ad59-41ba-b47f-59085269ccfa@gmx.de>
Date: Mon, 27 Jan 2025 14:14:13 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_pci: Fix Warning at drivers/pci/devres.c:603
 pcim_add_mapping_to_legacy_table
To: Helge Deller <deller@kernel.org>, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <Z5XmLKzhKpLAlzHt@p100>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <Z5XmLKzhKpLAlzHt@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lnSO8pSUdMVnTAY0kfCd5K6iJDFJ++d2teB+reRh5NxKc2af6Az
 199U1lFjNMZdifbN38PacPrtdxCHSLgDu60DPfps3+QuBBJIaKT1C6T5ZChaU8HeTbx3N3y
 W5dMkbHUH6l0aib6jeKCqtjIQwO+kaRl2Uziq1YzgsuMYWfzSPoU1xvZ8VNsU+sp335+4z0
 Sa/CMNn+uNmQMSHbzzatw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bl1TqB5wbgk=;71abVPOCIxY0W3+YoKwsmn30WuP
 e88oVejAwzi1sq25RK72jqLKbjOGst9IhIj17FX3LNA/1upVsfU2Ly22hLr59grhyyH2wsT5o
 udu9Qc/fS1m7CYk33NfT6sKYp3RbmVVvDNyqxWrYkiPnLN6kkXELulH7IgrZ25VjMjWKg6J7w
 7E1z343Z+jRL7G/0f0f/ouzlYS+p304LdZ2jVyGgbF4Gr4yUMwGZG6r4IbTDiuNV5QKbvMTTF
 4uzB7j7MlmO7lN4Pv30XWOgg0JxUEBmOYm4Y9wV76TwIMh1Cm1Beb5Zezz4LcUoYZfnt/GYHV
 iQLvf4OT+G9Refai7OQok5LzKUzAA5DphlkDkrGtJam0L6QYQX3Hkp0CGH5nCxorRjVl8DqmX
 3f57js9L9Q4GBHKTWaq6qUM+U/mCk/qisfO095dkNAIxCASb8vZQkMDFiS8bgxKJ913QpWlHr
 +HrNb7LhpKEfmMnPg3RqQ9oqc2Tiyu8MEY3gurMCtUbF3P2z/gTIdAiTzGpPZoOgLPKu0gbRc
 4URonA3IbbwFZ03OZUBS0tcOczLGLksi6PBueW5VPn1PHwBCd6wJGWKnIfYQrA+V6D9CeY0bM
 pI/dSniCCRJOrX49dog/xUk7yoiz2LtD9UwW87aSKrI5EDq1Uxx1MNynlMr6Dsf369+0XHJf/
 pq8ZNrHOcU91rm/k/OTCn3sn2lOcaOPn5gNDfeLK1nnnaiok1IaAUavQzrp7NfjqCVmDbsKvH
 Ksp+SDaXTTRO+kGTveH7Myn5lK7tzVRAx6ityiFb9SAAOZ1aVApRLDQixHnKnJkgEmQxPYaDw
 U6n66AqDaHLe6j9zrSz1f57Xun3cMMBOQz6BrUYmhIE9qRefkURjAVSGwwBq2CNWP3vk7vgBE
 A5WmeqkJaDb1xqXy8NeVot7F/X5L3+DPuR4h0ufjK4eCmTDkloiEBKsEjvc0yVdH59fivVcAx
 GvA6IKJqMJALJqqg1jna5pENt7ukZ8ZR6QfP4Q4DEq6aiwQrOBxz14I4C72xsrG/Ek0slmEKY
 I3+2N8pDSDcrgpKCF44J8uWuaNJfwF6dpZ63DY5BNaLN6S42GICbdVaWPzVOcXw3YgLLU9vn/
 ASclYpAy0Jbv+6orMYdNDilzefB36JMLpG7W+0CjSsQ42Uq9orl4rQMffI1HRA4e6GFmpmRoj
 sUCMVjQUQafl+jxHAPbRQnDQxqhmOU9WBymc0aMEb15UW0CASvjT3tCqnfqYbtc4myuzTssiN
 0addkxz2X0elOIAAZ1BEeVdraZgXAVC4GCVl9IIqKJm4MZW7+GBvW+OkaUqAvG6kH9moucx+8
 aqMjhpzXdSv5DjfN7nXNkuVPg==

On 1/26/25 08:37, Helge Deller wrote:
> Some PA-RISC servers have BMC management cards (Diva) with up to 5 seria=
l
> UARTS per memory PCI bar. This triggers since at least kernel 6.12 for e=
ach of
> the UARTS (beside the first one) the following warning in devres.c:
...
>
> I see three options to avoid this warning:
> a) drop the WARNING() from devrec.c,
> b) modify pcim_iomap() to return an existing mapping if it exists
>     instead of creating a new mapping, or
> c) change serial8250_pci_setup_port() to only create a new mapping
>     if none exists yet.
>
> This patch implements option c).

Please ignore this patch as it behaves wrong.
I'll send an updated patch.

Helge

