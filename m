Return-Path: <linux-pci+bounces-39328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE3C09D1C
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6093B3B79
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4847222A4DB;
	Sat, 25 Oct 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7I9bmfU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E83A224AED;
	Sat, 25 Oct 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761411236; cv=none; b=Rc1OE6fDr80ghZg8ZmLOEmQ17KncHVTL6E7OMjI++KfC5PDGHvpPfgDnbqfFMq/o5SggYNRWPoM5aa8T2ZC790IBJoEeqFOxfPHLGH1zRp3sSNIRKUvsR3JWS+Dnwk/56F9j1Gs8wMo+PVD0E+DT5uXdgeykY0YNTyqOfn91UE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761411236; c=relaxed/simple;
	bh=316Rt5F5vtnh+ViWAlx9dI2vqWP7zbk1bW1G77/F07s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AMqK06Eg2J7OB0X759c+yQnjqYvn8whGSpnpP6L7ZoY3pTqbR+392/QiPCRcQ2kXltZJZQXr50UiLTkB6mmsbd6OYDk871wiOX+MMEsppCIBetfuVKDeMGI4rasrXuWaaSKwcrNxuzWlWwMBNg5pfsWVWyUG1J5WaoHYCAnhLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7I9bmfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F69C4CEF5;
	Sat, 25 Oct 2025 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761411235;
	bh=316Rt5F5vtnh+ViWAlx9dI2vqWP7zbk1bW1G77/F07s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c7I9bmfUtWC7anEduK6k7QqzFS9ZDDpvu2LeU5OO0BPx/nl+PjIe+U9dA1G7g3IGh
	 1EMj1XnW7G2tjOOcImibHr4VZg/Ha0nWTme7RbdRYo7TGUuuSJmmrEjNVsG4/Xd4Vc
	 kXE/DIt5XZPBhKJLUZMSRy/NDFN8MFUlJuWYerGx1LyXOK5b210XQxmAAjOvu2fS/q
	 aqfzl2qVBGuIHnLsOzerQq+mr72yancRQP3H7P5nvohE6SUfXIjt6Ncv58nIIDMyIe
	 oP0WJHe+FN+JZDUfp9IOUMjPqQcDsOeMlwEyoMe6V/upMqHZFp7io3zFNNFWszILcN
	 s1/8FusIvN6JA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: aik@amd.com, yilun.xu@linux.intel.com, bhelgaas@google.com,
	gregkh@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v7 7/9] PCI/IDE: Add IDE establishment helpers
In-Reply-To: <20251024020418.1366664-8-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-8-dan.j.williams@intel.com>
Date: Sat, 25 Oct 2025 22:23:47 +0530
Message-ID: <yq5a3476q5wk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:
...

> +DEFINE_FREE(free_stream, struct stream_index *, if (_T) free_stream_index(_T))
> +static struct stream_index *alloc_stream_index(struct ida *ida, u8 max,
> +					       struct stream_index *stream)
> +{
> +	int id;
> +
> +	if (!max)
> +		return NULL;
> +
> +	id = ida_alloc_range(ida, 0, max - 1, GFP_KERNEL);
> +	if (id < 0)
> +		return NULL;
> +
> +	*stream = (struct stream_index) {
> +		.ida = ida,
> +		.stream_index = id,
> +	};
> +	return stream;
> +}
> +

We do

struct stream_index *hb_stream __free(free_stream) = alloc_stream_index(
		&hb->ide_stream_ida, hb->nr_ide_streams, &__stream[PCI_IDE_HB]);

and the default value for hb->nr_ide_streams is 256

void pci_ide_init_host_bridge(struct pci_host_bridge *hb)
{
	hb->nr_ide_streams = 256;
}

That overflows the u8 max argument for alloc_stream_index and results in
a NULL return.

-aneesh

