Return-Path: <linux-pci+bounces-38573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA47BECCAD
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 11:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181DD62491E
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6788B28727B;
	Sat, 18 Oct 2025 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sH6cxA06"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751E1448E3;
	Sat, 18 Oct 2025 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760780023; cv=none; b=CEzuAyTk3qnsSbo1NjnkeJd21cS2me8ktC7LnY7CzslZmDNbfSAJ5TqZz5roeO7D6evdU1JcA/EGKzVATZzUz0CKY2nU4pFcD3f2Nf00I2iExkH1QgIVHv7wyQfg92rJ9Juy+NUyp7UXdmr6qbwYPbwbVt6YA8ykYOU+FIlP1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760780023; c=relaxed/simple;
	bh=vyrEA9Xn7+fTNF+uNpgdCwGsRJedwepAfqXbZwl9tKw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TT3wpqamCZln1BNIHTrNLndrl1dNX2pQbnio7t/ngQKzDUYd/5foFeV0hdGZqwMh3zGgwD7UqlQQB8yV6WCI1dPdSmxUZLT0A6uXGZxzBcdJwVS19lxkVXSM5p7djYI/arBbwe/Z2W9o1KQDwWJ0sCoH52luWwuAgIAjnUQ9I6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sH6cxA06; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760780015; x=1761384815; i=markus.elfring@web.de;
	bh=vyrEA9Xn7+fTNF+uNpgdCwGsRJedwepAfqXbZwl9tKw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sH6cxA06/4h0nBgx7PIiuqPYQ2YLlEBmQ4vp7jpuM7gkweLy7QK1V0LVWPs3JImt
	 KoTv/uvemRE4Z+UlFG1v/KHNUhfyAbc4mbVyGJa45b/X1vMNMrDSFJr6w7HR2aGhb
	 B/+f08JXsnuGrvxg3db9zI6Sj1g3tCPOOVzZnd7b3b/Sz1Or7jOcEXzsFxpDfJfJT
	 prav6btJtCzr1GVKlod3kGsEBTi0cbTbZnKqz49KJ00XBc3XAGERwfo3wY7iUckQ7
	 sXU+iz9OwYubrb3+VVC8b4Pl0v/7eAyVoyTVS6xaOonvGhReNwMDQ+30Och3ju5MT
	 8lwpgRS3ro9ZBxPw9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.233]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xaT-1u5Jdc1NuF-00yR2p; Sat, 18
 Oct 2025 11:33:35 +0200
Message-ID: <0b35a3d9-1d56-48e2-87b4-0672739228cb@web.de>
Date: Sat, 18 Oct 2025 11:33:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251014113234.44418-3-linux.amoon@gmail.com>
Subject: Re: [PATCH 2/3] PCI: j721e: Use devm_clk_get_optional_enabled() to
 get the clock
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251014113234.44418-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:frkmSHrrCRc2PlwZbdSNiHlxfazUtn29V6HusRn4PyAKpa6yiuf
 geDvTXIHj+kpYFFv2/FykwKqqCsuGXekp0aipJBWQUD+kARyw8zBBjuSG/tfsN5N3OD4tjO
 BplH9rHFr0lYYlVVK6r6Z/TVAqsd4g6TfBJWWGkbttN0yR1WY6JYSu482izILzoY+PpotVP
 scvDT5bI0ZWwlumq19q+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RkC044W13ck=;rEVaV1CwHnFD93z53WkOl41LXtf
 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

> Use devm_clk_get_optional_enabled() helper instead of calling
> devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
> the error handling and makes the code more compact. =E2=80=A6

Can this information be sufficient so that the subsequent two sentences
may be omitted from such a change description?

Regards,
Markus

