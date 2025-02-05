Return-Path: <linux-pci+bounces-20766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312DA29417
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 16:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC553AFF3D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3618BC26;
	Wed,  5 Feb 2025 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FuNkhrAH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C4186284;
	Wed,  5 Feb 2025 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768238; cv=none; b=oV6lu1fm2naFvtqk4g9W9ImlTnS16nHcZQfiR4YBcubO9DNth/mJMIdpmllyJfA3taX1Qge5GT+blMnlfuGzV5BbAqRlH6Gnal6CH0d6u3OgZNCZEfIgyDBH1qdn4siGa2qYiyx+2mWTa6I8orbeYfdTs0cE38Z4O6j8TdpLf4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768238; c=relaxed/simple;
	bh=5bnC+RMJy9Go74Xk7wf5n2n16fM9EiwTk6qRnyxUz0M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=e/ecxW3EvZ+86i/+kIu72eDcNKFUI0YGbRH6bT1wrWqV3DUWvJUyfFe24pUuQHuqnMlJjc7tNrZHwliU7lS31LTV8FT2wCJlZnXcEaNOSUKZVJnLwnuTfu6u4Gm/CD6GPeCcqqhjbmGb6hmQ2TbztEpfkEDSh5roj8xwCvJR+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FuNkhrAH; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738768233; x=1739373033; i=markus.elfring@web.de;
	bh=ZTYLfFE7cC+DQ7FxXv045p/gA84CPFiSe7CIyfB3gPw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FuNkhrAHcHpgcrJ1R8UThkvUXb5tSzPA65qjDDR8C+8Ln1RsWNgPC1kwuWw+D2x+
	 sQSA6o1sB6KWw63NXRridI7fAinIMGr/b3iLr1jUSlI4jMll9qL4wTAWVTf0na6Z7
	 wmHGUDV9/JW0uFeN2jr/R6pBXHGPsFFSWNWdCi9/WFzZN2UVUOF3t8QTJOjsGNa8X
	 wUMd9HJt1vyPv/2ZwKQ2Zi4engNWhj7TPap7MeOJ7KSuPzfwRA7W9EaHS5Gf2pAeH
	 b7J8fE3F+tiebfZ2ULuUM8rZ+jrnh8O92salF599hYHKM/A9SZKqoW6+P1UTFw9sR
	 DYA37Pen7SJ5SHGgTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.30]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5Qq9-1tgVrR1wk1-00EhNq; Wed, 05
 Feb 2025 16:10:32 +0100
Message-ID: <f5462109-1603-4866-895c-b5c349261296@web.de>
Date: Wed, 5 Feb 2025 16:10:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84s?=
 =?UTF-8?Q?ki?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
 Jingoo Han <jingoohan1@gmail.com>, Michal Simek <michal.simek@amd.com>
References: <20250129113029.64841-4-thippeswamy.havalige@amd.com>
Subject: Re: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250129113029.64841-4-thippeswamy.havalige@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hHjPFyBsqQkZjlLdf4YmgMoKUnnN3S+V7S4jHFw41yxYr9N7tJm
 tLjQOZeqby2CZ2iUWA3XQisRnZinluElcoVSzF7Bk2mYG17d8pYNmBL0m7ASl2N3jNxeP9d
 ENWs60isQuYfdknyekw1fol5plBXXIY3jEo8iXA0aqWglpqMUbV7v49SscFmXL8tO40I+y0
 GOUr8Tmt2HhKeRQM2ZYYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y5KBcZ97QHc=;mvS+lr44qC0nRsDpM6iISqhJSIV
 GodAgrZ7cY5pH7w+jTGJjqHQiK6hgXyN8SyvMhAOOL2vk0yckSftL0a82908aQjXmaSfmVKRJ
 sjAxdzdKIcPpGS1rIYDN0apgN+Bph7qsh1yyG0knegLgYahfN4EJhhNwjqFHnpCkbn8uaUwy8
 FSUTC6vA4isva94mNFMOdVZDtDJHzlvQVN5ZToOiA71QOp1VDKOy0ipSCT1Ty335UltlKtVm2
 eClKjwNUpYmkHWni9MNGXLCpyCd1Ai+aQtOw7mQcSCy9u3NjweqlqAtwF0iIXV/e59IFRDm06
 5dsyD4wI4PLBKKNaKRm7YdX4b1MgagmAQy45J3zhWw/2MU0+/QvPUEuXJ8J/54vpI8fKKivVF
 YrbK+CcuHhTMtZ7rJkrccr0qw2m4dO0hAYX8avPX3AYxUoSvgj5FHU0uI5/Ue4H3UJTUuJ8kr
 1uERLFdPHa+9LLgAFipXP/c2hn0GRnqUvkbCgnfTAERITqCIcPQSWoZ5gt/fAR5TBC63CH4t7
 1bUf9GHLT30ma6kY84DgDgtvfoomE4fh5OHy1ltgiVIlAqj3eHmj9u9eZ2k1wpFkegIXqcNBY
 n18Nsc9e9Mky517yjzAz31PemdczFALiyaw1oboy092+0HufoLsG57xJSJqJx6VEc0Z01e0rv
 fP1rwhnkxHuFjyY8U4rsa0G11qTvjmc39vTRm/LI/zdZTZI5OtB4kn4ZGZNFJHArWxyEvpvqb
 tJHxIrsI08EUo+iiCGggg6rjn0OwM6hzaWfY2/qd9kYL5qDgHWJqAKHoPi0HxzKsitOKoWy7t
 U8fcmz338g0+xeVGUn+1Ig1DZPundegragMR7tKXQwBHIwPJNexdIL+S2GVKRxybre1YL4oM1
 U68jlEHc/02IZtqyNgKR5a3YGf9MXO/gB5IrZ/OOdqhmc2TV0m0r4NmVYmFWxWKoCmmpLUaN5
 svQthnALpcUVwG+qQS29uLJtUD4UrpNU/82pZGVb51mKYUvjDWoCJQ3eF37dqPOtqQOkvgSMY
 ep2TSANTlVfqBwB1izge1VFblK8YHmrJPvCdw+VwwXJr4U6g/eGDqAG5oRJyz4F+zzApmW8Qd
 DLcJn4Mctuu5hzGzoDQCv8Ta+ThXjxUQVldjJGrfM0I8CZpPZaWGuFMhEAoxsaqCB/RQVIen5
 DK0xCI5GxGFg0W2llqFmNz+XKm/vojNOjkpn0HFkx+zw+AvWIRgBMB/LYfhaemArqRkREUA2i
 Mk6n6Bw5jF2A7IigPioCpWXTjdsjm1kzWJ+Dvdb/jJE+HgDYUskzmj13RBDn6OU+SQ5MeuTTC
 trD4t/q9h8e+R0fn6lqAGcxb2d6otOD6hITu3s9Nv7Qe5pyIJiaJ5lD+Dt0DEZKApLZE7W3Zb
 ye5/HolT3GB4cOXPmvd+6wgke0n0Mrkm1oWznoCEl3SmXiqkD+VCmVdPy2yEikaRi9yJIesZu
 32uoDKjN8otSwfT7w7aO5NgggYMU=

=E2=80=A6
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -0,0 +1,476 @@
=E2=80=A6
> +static void amd_mdb_mask_intx_irq(struct irq_data *data)
> +{
=E2=80=A6
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val =3D pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> +	pcie_write(pcie, (val & (~mask)), AMD_MDB_TLP_IR_ENABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(raw_spinlock_irqsave)(&port->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.13.1/source/include/linux/spinlock.h#L=
551

Regards,
Markus

