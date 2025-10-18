Return-Path: <linux-pci+bounces-38581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E32BECEBA
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 13:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8435E831F
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536CC24DD00;
	Sat, 18 Oct 2025 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RD0oRDFL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBD1ADC7E;
	Sat, 18 Oct 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760787668; cv=none; b=XsdlfnkuCIOheBB7gCiINglKN3epZtd070sV4c/jT17/tYpyo65/G7T7VFjqlgjxBXDwuhD7ZQyo6XYAFF88glHLzVQagLXkn+U0KbcAnm8QtkVjkBBb9u/JjWyzhhSpgCTRpIW+ulbgK7ReOeoFDENW6J0M62G8wxI3uB9D4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760787668; c=relaxed/simple;
	bh=LiDlH8BrVQvz8trw9QM3KlEdCPM3TO/pVTGoFjDAUuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaCAHnucwwkaUBgt47grWtKGAOiSBlHoDwzGwPyKQXsVBeQHX64OD5A5jCPRwvVfzBzPdi3QuRSbdKlZq9VaixcmpIQvXqX54t9TIET2rHnzoTRIyXIXau0Rd7o3dr6kRrvgVvir2V4H+TlN6hhI+0h3hfXY3Bl1Z8pBJdbYtYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RD0oRDFL; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760787647; x=1761392447; i=markus.elfring@web.de;
	bh=rFRibB9Qt7JGgXkVO4Hx93pWdntl56FRy/NNmI1KJYY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RD0oRDFLAVyJeAgEg2Z5lc/gyefM4fY0NPlf0v3UEyDMR0zJn1hktmDx+BuezQPh
	 Ubuz3Y1rcdlGYrpGUVOTlt8KEbS2fmuH/A4Fk4DSJ/DYU5oPXegLpBFyoEoKtSwsY
	 fQsBcyiQD9NQ/rXi4fTJK71hD+EKg8QiiRNhp+srUlZmWcImsiARpUmC7sqXVFi+Z
	 vRCOqEpVevdMoOwMdGtp1p41FrP+edSgAmJbvFyX3T8J637bt7n17nBulMWwVhtoY
	 CqK8MPkIGh+G/yilR1S5FOeD+7Ru33v1O07IvYQwFyytM0bZfREtqMRqTw6KEWbH6
	 m2fKhOpUHdfcq//a1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.233]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7aP-1um33g2kNr-00Kkq5; Sat, 18
 Oct 2025 13:40:47 +0200
Message-ID: <b39e1a7d-1505-4f26-aa6c-c18a151be8ab@web.de>
Date: Sat, 18 Oct 2025 13:40:45 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [1/3] PCI: j721e: Propagate dev_err_probe return value
To: Anand Moon <linux.amoon@gmail.com>, cocci@inria.fr,
 linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20251014113234.44418-2-linux.amoon@gmail.com>
 <a2cefc72-de44-4a23-92d2-44b58c8c13fe@web.de>
 <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:brUrWs3f1wRlvb50xsoJvVd5EaCNX6rLdO+gQJ+rCOePPXiZu9s
 mQzVRW3tHeyUJ8GLTZOHmIVAiBP3LT1soBbrApPJbXg9C9aO26IjY0RdGZLuALcXxfvapQo
 iXhix1wfpm+VcEAHfiYBsG9TmZbmKQ7onDPKdgA3BY4PrF/w1QXQeEYujiTYQGPdYu2bqzJ
 zcqXxxhljGxr3oHGgCZ3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BcQRwCXMQJQ=;3e10CcDiOryBiF/b1jz+Xz04tYX
 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
 8X2DXg6pFFj0GJklbujzG5O5X+6OEOyVKBQ=

>> How do you think about to achieve such a source code variant also with the help of
>> the semantic patch language (Coccinelle software)?
> I do not have any idea about this.

Can another source code search pattern (like the following) trigger further
development considerations?

@display@
expression dev, e, x;
@@
 if (e)
 {
 ... when != e = x
*   dev_err_probe(dev, e, ...);
 ...
 }


Regards,
Markus

