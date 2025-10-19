Return-Path: <linux-pci+bounces-38681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 437BFBEEAFD
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 19:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCE274E5F85
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A18D204C36;
	Sun, 19 Oct 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AoYNu6Cz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D24414;
	Sun, 19 Oct 2025 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760895980; cv=none; b=EhLSkwVYP5z5Cm/nJz9SMel7HllOz+dW1fy67yC7RZkDwnfz1U3R+IAMBzL0wtyBal7MaF9CIP2znngvVsNSik77KJEIG26e3fvpcsDIApClI4+85sckemEBOfddclyT3gftt9ZWTj28maCSsoGN33tSoDSzQ1mYv7FiWgKZGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760895980; c=relaxed/simple;
	bh=EN145psRsrz0d+ZP7PQhoev9u3YWVHcD7NOVKzuDOWI=;
	h=Message-ID:Date:MIME-Version:Cc:References:Subject:From:To:
	 In-Reply-To:Content-Type; b=mWhjRFjqystJtMV9MwQi8qdVvoA9pV3DMqjKRCMm5+o+XlltjOuF+K1wEqmEIVRBQetPFD2TUfL94xSJhhcpZ2a4Q1RUQ1O6DZR4d6LNJRySriNGq4k+SH/hJBdwZ16RhF3vtpPjLpiSRsF5bXMV/01mBlS0qHOEVCK9GTpq3FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AoYNu6Cz; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760895953; x=1761500753; i=markus.elfring@web.de;
	bh=kQAc0UibkOncRkKIvQcXYGUpA0pSKYWfAFZPX+lj44I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Cc:References:
	 Subject:From:To:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AoYNu6Cz4U9DR/ZkC3SLCUGYLtm2epS47pj2a/LpqrVSmgfj2w1rX3W1LfHXPtuQ
	 0E8qnyEx+opHTbhjD7imNV+9e8P63Swu1Np9e5/fOylp3bE5qbuMZXNMZYijj+7U6
	 F0u6XFaD70fWOMB7PzYZOtmAz0lFfhStwKMCl5FtfLU5CXdu/oyUhBjaT/oG6CTKH
	 uWLYcUwjFs+PHxDdOMqXMsyN0dqGtjg4VeZp1+PtLkLGTM2+IMgGTNZA0FWFSMUv2
	 F3C0bvj+nOKTIitf16luC2r/dlq8+1m7k9sDhg3EKC0ziiGDb7zRB9wdAbqwVtD73
	 y/Kr2oCNe13pjRAmhg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ml4B4-1uTl1A3bDA-00aSSE; Sun, 19
 Oct 2025 19:45:52 +0200
Message-ID: <53826884-2772-4453-965e-037bf3c4b2ab@web.de>
Date: Sun, 19 Oct 2025 19:45:50 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <26975dab-9631-4661-aaf4-afa213104a13@wanadoo.fr>
Subject: Re: [1/3] PCI: j721e: Propagate dev_err_probe return value
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Anand Moon <linux.amoon@gmail.com>, kernel-janitors@vger.kernel.org
In-Reply-To: <26975dab-9631-4661-aaf4-afa213104a13@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OBDn8bnGKssNr77QFbAHY8RZK1BrBIYIrD/r90S0dn5UgtsTsF0
 Xj1Wz/ZJlcNyg5gPii8qG8W/BMdr183r89jmtSuqoTLk56AAi6KZnlyNUT3Wu9geH8uOCQ9
 JXlZ4aAwhE8AlHX8OmooofT7ndGQf0cjNBBcT3LH66S6l5YdzmJCr+s0ymaRshLkw6QDoXE
 +nGGgkvI6to1bsoJvm1oQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eJj1V8s1uIo=;hhrsl/doOk2iLBxkNnnEtnlFm5B
 gtSdhuWyrjwws5uJs/sNguntPU+rZWok/51+ELB2au/St6q43F1diGEWbpLvBaW/4ihiRRjIm
 Fon/dYL+xEHyRb6+MIxEb5U665FM3edgINXDYFsE74WVeq9RWPmz7eDqt+UN0Rs0rHsxlMIRa
 5bObEhcCAWMnJ/NzM2MDLgezeCORIK2Z8SRi7GwRhQBe6ccSodDlesGGPF5sM0VXSkj5nyJBF
 N1WNs1IChPJ8GIPPK2Q1nukShSUVg1/CNTGUgkKU0Mt8BwET/1HCZJls1qZLaXYdELJib3OSp
 WkS70S51ADnRNp2HezwsoCmtxNFANWeV38ZeRzA6HkUhDXN3kMCvMd8kePOnEpro6OgAOaks9
 bpimTcG41AQk/PklMJ71xWLoI49azVInD65hK8ChnjR55VFpvwGxB2bGwb9lpXESRvV2yENJ8
 3cb7rZd9DbFSOf4qFFa86xx0fX+uG335zBGKg1wA8EMGCl0alyimBMgUqbDweUt7nq8tDl+l4
 FpoCVvDVa9TZkjmSwh6bGNrLzeqpjULov1lyEqgC/aa7wgkP9PB/r3VHLQ0PpbcEppiyEh0nD
 pdmRX70kisHhYwnvE29U4P2+FqEmhTZApVj32y4gpT86Cy6oF6lrLXga4HgUfYk67YwYAlncA
 SrfkxEI83P8ud0CbYvm5YsPSCdFYzgp04Q2xXkR25t5kmVvrr7Aj68d0iXHiiqdOEsYBbXoVt
 wBon04PsZMMyCE4AHz2kuP+ZVdh9jHHR11jTKAQ87WrwHsM1sBwp0Ias1AoHnedIvUSV+oCK2
 8iIJ+OuO7rL1q18i56encwKahtgAVmruWXHE3JOznQZc9os3xVHdm66GZKWsXojBdksD12A1U
 hkxFntHm/PyShtj9iXDF4ArR5ze8KUNdC6avnoxmiM6zX8rQKEwzD5rva1IGcgu6usjod9ysc
 tfG689FKRvXAIeDZFLdvyXgAqyBsTE5Fjsv3TPIvJTcO3f1qLNINCSHpWaWed88V7XWvp7GtC
 1TLf/Dt3RNMsE9CkKSD6lHai58rC102H/Ek7pvpxIvi6f+ERtgl/TTo8UiZcxzmvEMxqwuHov
 KaLb/kiWEq8MTw1wl4Ah26oYv3yYRkCrgS88HPWoSqYQC4i+mfcee7fWjtPn29bNoHUgr7Qp0
 AJYcREjYZXZc3RNBdwWKP4AO2/IBUHdG/T6iiIyHxRkImtdJVtX4zFhgsaflJtY9TbG0w++OD
 5jZ1V41Hueo0XR2rC9mCKL4SulxTKvWFk3BcvKS3GTqT6+ZY2LdqUSc2nSdq5XKmVaDmkbIeA
 DLorJ2JZy8y4z8bDyU/5BSI9w2Avd1C9CF7xgBJJidFxpkW02kge9p1BrCcjbaDAEsBBwincJ
 GmiSDBNA3tfQq5b1zuE23tdmv6l7jLQmOz8zSzgtWqM8CglsTxExnX7KUntZFZ37YEjUF9QgR
 gUpyuT6nRG75ALsBJ0JVJEPxYYug5Nped/Ae4uJOmw8IQOZ2z5Zca247lk6lkdF7zl01Y5i8D
 w0Lre/ZL+/eAXe6RD39WLxJFmHmpcWjVHdrzvajelyXT+Z8qUwSfbO0yAx25syYsnb92AewiW
 AQMjBcZ6RJ2II71Sjjj8p5krjGP/b/66+2prn3YBF+A256mR25WJxTUxm+6cq2BI08DYS6/Np
 IddPohr8Am0psk8Rb0NdJJ/BehZn03LzjBKPL3AYrKV3oWfKbM+H2XeqfIN0ak6uboSDR19YM
 6fOOAT0MwsFQoYVZN/LrTDUn44iF2YF2Qq9hStyyAbeqNzEkkGOEmPhOy8IVnyeuTQLcWW7mK
 hcV8+RVAdSBbVmxYqXzTXzxkKop9kLz4KRba8lEt0IjW9vSCM0m22Bnwj+shdq6+MuaE2ki07
 ZmQN/hoJFgdvLOGfFaqZBhfy/oJCMdImYEqcvdv6TabB6gYaBWCsETK7d+/5H0vaLWltVh0sX
 fRZB5q4klhLc4OqXttloBmetLSFyYe28UZTvZEUt1hiEii8ihRixnmUC0cj/YLuoNFKq0wlJt
 Aj1DTAnmzj2DmRyHOs/tiUoGgsmZuT6tjg09FN7i6razD1j/PrSI3e/o5uVs3R8lONgMMGkhE
 CaPHcku9qX+qiDUX9wF8NiKz6oj+23V+5N0f9E+4lTuPT0ZsPdXYr1/O3PV4YHfs5N6LHJ+xl
 rUc/wVha/Q1wXOXjmjASlaGIs3cYYbeH1/weVXsZ+KlHrmn/++oIhuDRADgIckC7PZ0ps4N6F
 FYLpNlu3fGRmVPFMIWzmzxNlQ8xFRn7nEARd5SfzZXloWkRMYk2rN580f4TzRE02XBYmdeMHG
 wMknLc1P1/8q8RklolQxsXbI/5mQiquMlrW5b+KExJYkx+L2+Y96NLQ3M8u1zZ53jqdHcKAMh
 XRuU7JkEGn7c4F4HeIVfQFDYM6DzRwuwv1bdsA+quNihFJ7695gWP+7WT/sI7z7pK3FT6XQAS
 aCqr/pTGcABkVhZDPRCMkIdeAw0K86Vlw08/yzBuqyhhtoa0veXC4u6KjZ1pn+LRC56cBDkEm
 93NTG4pUyxKy6z7fAIqt6tjSnp+6+IyosMr11N2PkkdrXa042JnR55DX62ULxbUKDhw3GZMtJ
 mB/9zG6HoN5iq6wne9nX9pejQrSpImwE6hdcnl+dhbk1cPdUhI/4BgDrR/DUuyR2JKk+ldTRE
 U4DasSrQHeFy/Ce+8m1TE/25ZZa4xUSsIuSFRdv9Wy4Sr6y+AKFAVAcn1nIh6KsV1Bk7wW8Fi
 96nKW9Io+yodNHu/w3GTO2+7iJMoG73/2Bu/GSTDbHQjwN22gQUx/YyTl99L/u7O4BkkaXF3y
 5W0Od+oM+l1zloY6Leq90I+a/cZOVuGj9MgD6k7NjHG8nO62Jx54/osCAGV3jIk5OYZFd14a5
 GeBpRGobmkC7Gh1Bnhf+TQsJcOpn8B729iZNy98tY1xZDOHxbg9BdmMtCtiXDXAHIU9OrlSyK
 QbVDsQspE5enHfysUeSNdRU1m/07P5gqz75QzRx6pCJXkBJztkUNip6w6TGOhlkANJmALNEG0
 YOa8Dvt6rxSlOHt7q9yfgDD+H9mc69yho+As8mHLahhtRWvYjS6hIUl9NZMr43CsqyBZ6F55W
 gWKmzwgV7+2wA3w5GRVOOdBbHzSaUpNEk03CN3xnBqPCN3cy8ABNxNCEya07DUiFH10aoP75M
 cDpf3LmH+RcQnFMfTouVBGB7VhUjAY8+7nRp//wKJtkS94jywGgqWjoZ+eRb6NP65mol1Iip0
 /B1I5uEPJQbOwc/QlG8EDGpRR13MFl+s8kkqr21dIgeKAgRrE6Alq4OkG1MMnB0O/bOGhqLSn
 bXH39fnvk8Pr/Lc/lfXpabesfcOYpwsJpL34ii1bjUClD4UVceMqs66K88NudS9/fVwxM1OHU
 cLYmR1Kn9ujHiiByVlbCC3LLAnayhx167fWXWUVHV1y1Kj/u1xMJQ+zY6k1gu7bfrLrMoNuSu
 pIwzzhJupXPWviQ0wQvMFhTmKckpQmWBDE9Ofjl+6FGyFLUM5xw2uURq7UNfWYRzjbC6cnVBx
 BCFRQkGwuvmo0ipRG1GZCUEr5nEYWlMY8POcljHJPWfmlgEItmzIYYrVflxbsMKHOmR7iOEGf
 PzY2Rza28SC6fQxc9PdSpPwads20fhe0ZI6pz9YgOJhibMyL7tOULwyMZt6j6eVgVRStIx+7U
 T29oslsEm3tkacSxr1dBJuxjeeN3+7+ZAhx9fN7nq/fR0c+CFlk6UoNeLUnCV8sR4wGD28h0/
 5nrrsTMDApy1/PKAoGCBSenF47iy1wUHOe3GUsDQjWe6oAPRB07jMEiYy+zD0b1ir24h7QMAk
 D7Si0WtMoWnX9pKivzdtOyOv1IWQfeBORHVGdMCCD4Vh21gUSQoXEOUSnbMUmAj5zHV8Efhjn
 6T39EQHg67J1FqtfyZkE7Saaq9s4UQ4KVNY7rQc0lAvrJ6hzXWsl7Q/SkPOY2Q4dC/AYpBzRP
 enmpF5PUQWnkTSZKiPcTjBA9hkr/HbqBzPn/Nz+whLaCh9Gq2d0O9hP/mZ5G382JRMo6sl+ei
 i7PyLqO9De4v+bz5vqolt+O/d0JfSiHI4mPypW1DwdIb2GDWO82mzGHVAtSiAzzbkvtFSqEWu
 bLtGhxkY3Pya57MaCKahtnAV8cYfQjnQQNG4GWjE5NpbnfNVOf9XMkV33F3EjiBCYDNYdaKY7
 YX5DEDTGv3ZJknKq0OsxIr0USYxSJnTtixGHt1YiWzymdJx+NRWXvkaMfcFi3CnmHHcGODQLc
 2BCjZkApZZjmSsQBbjOF5XzDCv+PuCR8jsTjLUkwJyCdlq3GyX8GphmsZoXMRAMjxBBwyx1lD
 lb/BKM80AGTUjZSO/637sWTImD3BgUAOJtqAyBgzKCVEcRVPHSVbgBNm6x5mp+ZVQGce7yh0W
 yJ30llRH+Aj7pbAoDMAM5B9dEjVhUWvF4rpKOTpttH03YYPgIXRaCRecU9N0fwEEAlHaKWwIH
 vtnbRqYbLgwewDUhPY5ISgi3ML6Z2su6HSSZ8U6TaSrDarPeJD9Cg+5iBDGDVn6Pd1o7S6wdS
 GRH6MhpppJBsV8EWzqgUTgI0qys7zmRu9gbscP3jlS3+UienyepZ4mPoazy77qR1wxltnCN48
 Xq9vzBoOqa+ZL/X0XDvDPJzHUsj9qSi6JKdfy6aH1R649i4XiGuP5KCdfVDUjb6vbIoIgwjWX
 jJBjPz901cb8IHr6uUcoplHsMk6An7PMQx3YNNN6oU4gboeS4D6nfghkRJO5LTgm+G8yV5na2
 O4bRSXzyzZM8aDtx37hew96u6oCV8KuP6xq7N++Vz9Q+LrKIC9y+lfJartJAEUTI9k0y5Bklp
 uuesGRr2+IV0DrXxZ2jAUX7vBniLuQ+80YCG58+twosYF2eGd9p+WcfYvHCOIGFI5LKeAP547
 TCjaQKEQT1vwHsJjDkjiPOtK6T9R0RYjDSE7WxwI6mGQ4J3F34zXMztJvgjKaFjYDyUa4xB5f
 QxQ6lcXoIh8JWCmQUlNvf+6bY+9aIoWCebc=

=E2=80=A6
> Using:
> 	ret =3D dev_err_probe(dev, cdns_pcie_init_phy(dev, cdns_pcie), "Failed =
to=20
> init phy\n");
>=20
> 1) is hard to read and understand.
=E2=80=A6

I would like to inform you that it can be determined with the help of anot=
her
small SmPL script that variations of such assignment expressions are used =
in
108 source files of the software =E2=80=9CLinux next-20251017=E2=80=9D.
How will development imaginations evolve further then?

Regards,
Markus

