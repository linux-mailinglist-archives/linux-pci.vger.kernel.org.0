Return-Path: <linux-pci+bounces-21996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F758A3FA04
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F91A8637C7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D3F1F3FC6;
	Fri, 21 Feb 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frCVHTpj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B01DE4D5;
	Fri, 21 Feb 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153238; cv=none; b=oM7PhGQfL/4ax9i+1fNueHCWeoU4svv4dqdsrdwVwDaHnIcJ8o7wKgOLdCO70dlxYZ2sunie+w9PZQuAaLHdrXgYMtwoB8Wyzy5LI/b9+BBMANwmsx+bjPLp4uzlx9Lxf5WpWQxwhvukiWLBz4Fz0ogk6bKtadYh6sydOQaJDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153238; c=relaxed/simple;
	bh=PE0mUF1LBVVFVnCNM9w16uhviJ1kUZEN7P9yj/uxKuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gtmU9SHBDeNcRE7epEiNoFiPe8KhGBmHJBouMsCBhHkg+S7hs3M35DamhSgcel2fUKq5JVXN9xyh3tYE+fwSAh1vodAiEVVBBhMrI6xPIVztYuOfqfHJN6BrmqcdaqwlYN2qZ5m1QdTFVyEXH3b0+bsEvWzBUUodvp8RkJOkoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frCVHTpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106DDC4CED6;
	Fri, 21 Feb 2025 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740153238;
	bh=PE0mUF1LBVVFVnCNM9w16uhviJ1kUZEN7P9yj/uxKuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=frCVHTpj23uJeJovj8cgXfHA5bIObJ2tSBfABOIJDKzPYNWgf/3OACabEqrHAAH17
	 sRyUVQbUZgA6wDff9xtSf7/HDK8v9tQGt01BDl+IDy6qZqk3qIrrHA7Y5u8Ylp215V
	 Kw1CZFR+Hl83AIdU7zzphxAXoePJd7NYP58BsgoFzvRcSwhf7qUpiaDZO8pF+BDU4R
	 fDUlI+ETMleS5y5r1Lm7R5b+9o2lgW0Xf1utO2aODFIyQLz4qmVBFy0X3leqwS4nrA
	 ST715VXNReZhQieHhLqchSCY3jKwpdiGl93MNDtPfP7aID2vY3VFMcAbK1dHOTi555
	 iqg152qm8Tvjg==
X-Mailer: emacs 29.4 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
In-Reply-To: <67b6a3fa7ffb4_2d2c2947f@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <yq5ay10oz0kz.fsf@kernel.org> <yq5av7vsyzre.fsf@kernel.org>
 <67b6a3fa7ffb4_2d2c2947f@dwillia2-xfh.jf.intel.com.notmuch>
Date: Fri, 21 Feb 2025 21:23:50 +0530
Message-ID: <yq5aa5afway9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dan Williams <dan.j.williams@intel.com> writes:

> Aneesh Kumar K.V wrote:
> [..]
>>
>> Also wondering should the stream id be unique at the rootport level? ie
>> for a config like below
>>
>> # pwd
>> /sys/devices/platform/40000000.pci/pci0000:00
>> # ls
>> 0000:00:01.0              available_secure_streams  power
>> 0000:00:02.0              pci_bus                   uevent
>> # lspci
>> 00:01.0 PCI bridge: ARM Device 0def
>> 00:02.0 PCI bridge: ARM Device 0def
>> 01:00.0 Unassigned class [ff00]: ARM Device ff80
>> 02:00.0 SATA controller: Device 0abc:aced (rev 01)
>> #
>> # lspci -t
>> -[0000:00]-+-01.0-[01]----00.0
>>            \-02.0-[02]----00.0
>> #
>>
>>
>> I should be able to use the same stream id to program both the rootports?
>
> For all the IDE capable platforms I know of the stream id allocation
> pool is segmented per host-bridge. Do you have a use case where root
> ports that share a host-bridge each have access to a distinct pool of
> IDE stream ids?

I am using FVP simulator for my development. Hence no real device. The spec=
 states:
"
All IDE TLPs must be associated with an IDE Stream, identified via an IDE S=
tream ID.
=E2=97=A6 Software must assign IDE Stream IDs such that two Partner Ports u=
se the same value for a given IDE
Stream.
=E2=97=A6 Software must assign IDE Stream IDs such that every enabled IDE S=
tream associated with a given
terminal Port is assigned a unique Stream ID value at that Port
=E2=97=A6 It is permitted for a platform to further restrict the assignment=
 of Stream IDs.
"

If I understand correctly, the stream ID allocation pool per host bridge
qualifies as an additional platform restriction? If so, why is Linux
enforcing it? Wouldn=E2=80=99t it be more appropriate for the platform code=
 to
handle this instead?

-aneesh

