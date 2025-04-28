Return-Path: <linux-pci+bounces-26941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7256BA9F5EF
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 18:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B593B27BF
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F2E190072;
	Mon, 28 Apr 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tyNw0lW4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FE784A3E;
	Mon, 28 Apr 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745858174; cv=none; b=b/j3mzuVbiZglrRli1yyV93UFrD9iI4RDW43c6PkiaUwAEdcSZkSAUsCQsSdRcUW0bnfXqw79owVWrGdFnk9cVyZJUyHbYc0AJe/xxgnalQVBSP+Ftug3WofcZtDpeWpNKudpTNOz9X14jC6f36HpgNUdzVs39k7FHy/HvKPbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745858174; c=relaxed/simple;
	bh=rSd+mq22HXItQ1CWU/rObAPX9coTCZe9TbtulurlVRQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Wz1/7Mn9mVoo4/cLpRz16iKEfP1u9bNFAMo0RYB0hLmngYUNi5b+JoSPkzzUKwLiWyx7yyEwLfKR0JxGBRAG/Uy97o4Yw4oHNZ00wfIMpqhpEka1PqOgEwP0FRmsmU6zEWu5GMcoqCh6806waJ5yK1kNr5mtAYUMyFI7WBdc97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tyNw0lW4; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745858154; x=1746462954; i=markus.elfring@web.de;
	bh=3xi6EXzO4TUXUpbmiU3Z/BMkgY/7GZ4i9Wj2l8Afgnk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tyNw0lW4xvgDvMX0HvEK0cZJ87IIBOGBaNz1peubUxvK3n5LYm9zJhOi0pKFwrzo
	 0lsMJ/rV+aWuz8GprtPCKdqegmUJkP9y9Q3aCncPRM9388ZUpwBEaUzrKk/F8tBzm
	 Rtum3NysuVDWCYOAgatLhVw1KF+DrBCB20/oa3MhcTcyb8d+J+IZErvmOjMIJMPXe
	 L8pwC+lroHiYhJm/rPrQYbvETEU5N+I503sajV7KZNvrIeQRMoAwQlsr2gyvYCs4N
	 /QN7mgwMnAHiGO+bqBRQrnxbyWgjF8gecgWDh8YRDNoHmathyGez+I6/EKTdCmYYK
	 3ZHsPCmWfBu/oTHX1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.68]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MW9ra-1ubWxE3gnC-00Jwgi; Mon, 28
 Apr 2025 18:35:54 +0200
Message-ID: <242118cf-4dee-4a94-8036-645d7fae2efb@web.de>
Date: Mon, 28 Apr 2025 18:35:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhe Qiao <qiaozhe@iscas.ac.cn>, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250428085610.727327-1-qiaozhe@iscas.ac.cn>
Subject: Re: [PATCH] ACPI: pci: Release excess memory usage
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250428085610.727327-1-qiaozhe@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VqYtrAzC+soKYMrNE5dlgDO+GVsVTfZgPx9YF2lMD6BtVQJJbTy
 EtEsgaSOAbqstpGIrwhW9BfhWEWlgnfDwYLUrOtYhPVWHX9sNPdhxrGRtvq4pD6ML93nPUC
 M+EJ/exA02x6VbbBfd3nLatagdDKPmTvQw381RGW1OLFbepE0rL+R3VC33IiImlBxxo52+D
 21xqbzxJeIHKqkDtlN/WA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dwhA10be5FY=;d8dA0joHeLUSlrsX90ugYdU0KDS
 YpzTzikAAQkzCDOxGj/m4tcMiUKxwBeKPlPXUkERApxrsGx1X68/g3WKo/oOABeWtUbMZ/XAJ
 6JY1y3WbweC/jsOD+P/2hEKVhHNNNp1P9kc2ShsPgjem6Wi3ZYyFLQJvK3/5V6dptTSV6um5T
 AWu9uv8dmjWyYWeNIyJU8FYyrQO8NAy70DOryvZn1q2DHYsQiG3LGg7xRvYWZ+eIscIRA9arH
 kHS0HCYeS+Jv3t17kP7zOIyw2GbtEoic8eBpto25/tDX2oCCOwknkUC3dhsTTEqWJrxT52HZE
 I/i4a+ON/piEckbBvurQvY7Me0tRC0dLCXK5g8fOjVcA2zORoKu+o7YihuoTGVczbtMX01zNh
 KqLDwq7OIcIi6hf2GE8iuU77Vd9oNaJXYOfvIrQjbUkSqwtVj8ebK3Kwd75/97krJoM1r/8MP
 TxJAzZMwa1f5CGmIH1IlYXkPDSmMUIEYv3C9h8vyz27994Bwx5G4ZzLBjJNMbGfJkUBuCa60r
 OjfgcsHBVleIieJ+Yi9BS5M9ITLqlGPbJH0Wpnc9cSwH1MgbAhw1mzo8GI9OJLytkTn902xiq
 q0L+7xt2rmj4/kwXOA6wSu7BxjQnCVnScXFD5JnnzWijGu7KskpHerXR3GbX/owaNwxttbIyz
 R+6WBT8Pvnn9shEo/h7fE7RgviU9JiVEuOFgYLFCcCEdqpwHack6vD6KC3Ob/8N+IuWUCh/gS
 nOnxbuuNg5VFoLyrcp3ArKUD9Ov0HvFiBbUusGhLo/hrFG8LPHnfla/PT5kY0ZeU+Fykl08bv
 tNBKM1dTV6Xw1nCHSBKcok1XA84oETzVMpsLTpT0Zdw1jIgOcVkgntikoQcbQVrrUQBjl5tVQ
 OkwTHKnysGveyLpFc6yfqDu0f/iz+x7bgpzcvEH8ttKj0i17QM0+0kkzM3ePj3d1k1oUYZQ1b
 rcDLYW5G8JprkHjHq9ZnUGxVQ+Y8edwYfu5l6NuJsY7twEjAu6RmesXzOlhGq4LahczPrLtkg
 anbpd1LmeIunzR7ETKi5R9Vo7szYZxJis/Z1g/3rRyc7P1CvX9Je9ihoGr/vBOOgqXxGABMIK
 YY2o4VyHN5cZ19mK1T7VBDngXy23o85DqtDE9LgUn2aJLbTcCXLmReTHTTFBqnJ6MQI3LAix7
 G2rqorQj0oeuY1Aah53g9CD4tzjDfUdHM/l0L81H13JqLxaHLtrXto8oQF9s2oAWvV8o6dWmu
 oOAII/cHGBl8va8ep9Z5dudPmC8IRGIFyNyvm2UVh9e4jmxwwsguNSLy+vKjnF+Hi32hd9qvk
 mZ0eBLXAibO1BwZrlrX/fITIO+h9FT5Q7e559P/0ev9+SmJDP6fXLrwUHCKJZyYWhYivJOGOi
 KmG5uOryfYa99yu59Hp9EYdUZAg53RN6D1ZP8ynS6vsHqnSk4tFxNLy9edg+UeAMHr/SRYThQ
 DvfmEjvPFcubOZ8Ce+VF1ux0ZOYl80qCAcMILsX8Traow40P5Ss9u+tva2s9aRuHLyPAxYcTh
 XzABa5mfZjEBCoL+yoAtZjmbECdYEUlLMYEhLsmjg3HJ1LU7GfAHYniCBYW2Iknp1mvHjkEbl
 Xso/aPU5kNIMY/Kvsx7TBSEtUnxyIFprCwtRSfHW13MGF0ug8TIFwX4JRNsVyaIVwLqNEuhNj
 hzmaalYnB9U9ve0QkdiIInfDOgaiTmqsF6CqhkYuTlfuzKykZu1Vdh7mLChdhE/bNzUucu67Y
 TqS6XOAVwo6+fPV4qQoAMD67pDbFo2qT0IOh6oYMTn8C3yEFabP64et+oxhAff6/KTleo5tbo
 0b3LlSSpJVbin0sFRyC7p8UXThoLuRnQHVcSyLEpULWZ87o/6kGVjZUIo3cR140dKPoPQu8uF
 fZztbs5dUrmiB4lw7LqWpeeLX9pz/5vfm1BeVuZ1lBEw3O+AMBbDjdYs6LfhHKH6U7eFPbTvM
 ubBRJ3tzPc+PbCzB/sOJ5gTO+VuQHruGbP1MQA/vRefncryetenrOrfMaBmyZVgLcflQUQES7
 xO1PS8hzLVbHmReclj8rXLx20LlO/0gjNjZWarATUwpbOqb4ojcxegedxIGOTuhZJej6qLHCz
 2JCIEBjqU2tQSKjH5sxSqmwbYq7FOVDsb4u/v49I8wAi17j7XyQQEUyfXG+7FhulM4KKN195O
 BEjzGQvrQvoGXpyq1rbe9F4Jn9ZiEb4qH2y1u8Tqlf+nLC8y2JhRrLy5fyzeGYTrX7oPB5q9T
 q2b/pFAAvCsR5pZFZo+1UsS787nzsIsytoq6JVvcP94R141+5Huz5PIoYX7aMUIonKA0ezyNj
 zI5MkkCacYVgZkypx9KCUP7eWL7qzcQZRBxvuWV1MwsRS4mASZlxoLoA5P3DhPA9/HZlO+32Q
 IZYeoY8xEtr2uUaSis3O7BzyBeCaBT5r0RXHPHXRan1rpOOaG8ftjwwh78+yH5vpr6PmOzwpK
 pCt5Ymdp9eEgV698pGVr6z5jxpSI577yNfSOuyijCyCKJHirTAKZBLO98AEkZYDyF8WlNkJ3M
 YpcWTn2MDOOGiJppNQCmqXJHzdJdieVcjeFWMnxjT9jkVzKBu5DcD1aB3u3ToOcPkSOjX51Uq
 yQ4RZb1Sr4THk/cpiFJIPdgD7IByZqwZIS2XyFt1DBaKjLDXiEbkJ51bvlT7LF+R+nh3b9ae/
 Gq1XOJMyvxAg938/X7wrGqaA8xbKI6UM+YgpKnFWtdOUWbzTkB4i7vihGcUOmVqY6sR+Anh6a
 EgKa9wvxp/NsymjDH20Ccz7SjeNMS9Vi4hw4sO0uwQ91CqYW0T0qKxK7vjm1eYRBVgZJsvcBD
 E3G6en1/IoP2nCF2m0oR9O1wUuT/S7Br+WCwFfrjCLRGIyjz8XDhRDtPniLcumUH4t118oWyX
 KV0LrremCSmA4h/wshcKwXpxy8vLRwGYfmNDK6Qj/OjlKl/LySngFubpLfs29LpB1C6E/KJxX
 UFv3p1D9q/jnXKDUnbt8To3Tb/mLWywpkS0qEjX+QYm6ICC8Gcgd

> In the pci_acpi_scan_root() function, if the PCI bus creation fails,

                                                                failed?


> the allocated memory should be released to avoid memory occupation.

Do you propose to complete the exception handling?

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.15-rc4#n145

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.15-rc4#n94


=E2=80=A6
> +++ b/drivers/pci/pci-acpi.c
=E2=80=A6
> @@ -1710,6 +1708,11 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pc=
i_root *root)
>  		pcie_bus_configure_settings(child);
> =20
>  	return bus;
> +
> +cleanup_exit:

How do you think about to use the label =E2=80=9Cfree_root_ops=E2=80=9D?


> +	kfree(root_ops);

I suggest to use another label =E2=80=9Cfree_ri=E2=80=9D so that a bit of =
duplicate exception handling code
can be avoided from a previous if branch.


> +	kfree(ri);
> +	return NULL;
>  }
=E2=80=A6

How do you think about to benefit any more from the application of the att=
ribute =E2=80=9C__free=E2=80=9D?
https://elixir.bootlin.com/linux/v6.15-rc4/source/include/linux/slab.h#L47=
6

Regards,
Markus

