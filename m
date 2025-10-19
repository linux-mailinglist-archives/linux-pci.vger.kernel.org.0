Return-Path: <linux-pci+bounces-38679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D833BEE9E2
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 18:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24942189A7CB
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B88E2EC0B9;
	Sun, 19 Oct 2025 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VpV87QNB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733372EBB93;
	Sun, 19 Oct 2025 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760891144; cv=none; b=MmIN/6LkNQq+kYDPw8CuA9tYmQ0BmzjPTGdRdQvsZ7N9z66+9q2ffi5zaIo4M4gQ9134NL/IJPAGxJSR0xl8U4Ta2u8F+cRtYd8+eMnq7OUNQsqGGUbHoC6HlV/3wnjKckmIqV6U8k9jEhx/oHauxhFmIIsaYFpSGMYMwFuuZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760891144; c=relaxed/simple;
	bh=PwnNJ7VG2VCadOZ2lJxq1NhOWg3V7ScJ5VyVLdN2i8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDeLdDX5chFNXbn+T+ZA+OHLEkXF56Cjnfye8Hef7hv1F9n+sjbZW7i10FxLCP82IONKVCBkIdtJSHZ+LOCOj/I+bimdVceod0JOo2PgQS+ZBs2sOOy3/Wfs+5NVFr5GiXSSNzIKKAZuEiUskwKwlhSJGPm1O51gH+qV3WgFDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VpV87QNB; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760891129; x=1761495929; i=markus.elfring@web.de;
	bh=PwnNJ7VG2VCadOZ2lJxq1NhOWg3V7ScJ5VyVLdN2i8s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VpV87QNBXdcP7KJ5Ydjq15z0b7m7UvTl3eaDu1VYlbmJ737/3wIKa+G9HqrXsx50
	 ue18NJ4WXYsCsdiJu5WLBygRRRQopyQqoDy4vn0J/mfrub8iQJu/2r6LbVn5L9CQB
	 GEQ+t1ZOGmUdw/UEpCER5ECojO/VVKg9G9afuW036Il7fXVixigCnP+TTab5eUO5X
	 NwI3/bOFSlhRguWRmODEWoIXwmM6dsL9l2hTS6ghj8YBjjx+lOzvC1o0CrZa8F0VW
	 3x7tcAm0vQwFwJGQiVa/b+CIz/uz9TYf73Rfy6Ma1kpqzAVV4zH9Uy3fejOs3pZ3X
	 Mto5n769afwQxiaO9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MovjQ-1uPwNr3Ysw-00gWxQ; Sun, 19
 Oct 2025 18:25:29 +0200
Message-ID: <fe93e337-7d8e-4b82-b187-b5a67b627544@web.de>
Date: Sun, 19 Oct 2025 18:25:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [1/3] PCI: j721e: Propagate dev_err_probe return value
To: Anand Moon <linux.amoon@gmail.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, LKML <linux-kernel@vger.kernel.org>
References: <20251014113234.44418-2-linux.amoon@gmail.com>
 <a2cefc72-de44-4a23-92d2-44b58c8c13fe@web.de>
 <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:umLVQJpIYGS2+HeShb6AnbRIlX4jVAsM0N686gdXuV69BTJ1sHo
 ClvWmWlXilkiAjxPd0bgRxjIqzQUg5Y6VRAjRcPndrg8BL9igrGjPjOSUQ6Uh+IjhZ6sYlV
 s2W8IY56Kh32rfuVtsHQLVoywvflUGRn/ccAz9sR9vIz+J5W9Dv90BTlhv9gm+9zQ9/6tgl
 VrkgIHUHK9EeadmLUGj3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E+vRZbEifN8=;3GPNTm5dJYrlVOpuzv3N0+SoRyc
 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
 yYxJ/ZSB/CZB5XbxAXrtp1r19Rh5kvnAUf4=

>> How do you think about to achieve such a source code variant also with =
the help of
>> the semantic patch language (Coccinelle software)?
> I do not have any idea about this.

Your software understanding evolved into another direction.

Can the following source code search pattern represent discussed developme=
nt concerns
in a succinct way?

@display@
expression dev, e;
@@
*e =3D dev_err_probe(dev, e, ...)


The evaluation of such a tiny SmPL script can point out that 14 source fil=
es
of the software =E2=80=9CLinux next-20251017=E2=80=9D contain correspondin=
g update candidates.
Will any adjustments become helpful also at these places?

Regards,
Markus

