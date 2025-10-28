Return-Path: <linux-pci+bounces-39572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88EFC16AAF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 20:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799AC3B8E49
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 19:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE5C242D83;
	Tue, 28 Oct 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AsbYHXLY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E0621D5B0;
	Tue, 28 Oct 2025 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681107; cv=none; b=RqqDdzJwO/KLkoTGBteM13PZWqXs3wmE4E44XZZCmIritClsWaX2bCuU4KzEbgRWMNFsUyrzCjiVxELHQ/r36fd5MjRmeZcR6Lr8G58LPr+ob0Oj6X5n6hgH+/mDYVcwRhUJxJP26//neaisec4VteJ9nZE5+XzhrDDJeicooOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681107; c=relaxed/simple;
	bh=E+5ijzIQ0kS0H8i+4cnpFTZNgWXv63PgEQa8RHVthfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFKDf6HY6Q7ft12G1SLsfa9F/ZtOVETZ4G411aIynfBRF062MZdbMbPAYW2a4r/rfnCxjA0DsnqBgCUpsInMpJJnFp1/uUKVoQkmuE7/5puuOY2I37MEqf3UHHTmUidmW/pv66sbB+Ce6//LjM6CVn/UWtKOvP44uXkjb5wkd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AsbYHXLY; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761681099; x=1762285899; i=markus.elfring@web.de;
	bh=HPR7bn9u3armvqTiVBDnasIewghcApJJ0SXmHX6cCZs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AsbYHXLY0u9l3ORP/80P2qk1FULBbjxeIrpMi/Ns0u6Mg2UR+8dHItYgr2tyi5AD
	 ld7AcAi0TfKCS0cwEsO4FgA4gqhYTmtmbvG2SnWIVJhBMKs7NGQdKH3ieiA2TnK6V
	 yKBegd+FOWrH+WT+pye8n7okDvPTb4N83yQNU5lemu0+JQF/zRH8MK+G2Ew9woQWy
	 JSJ9sICixWh/ku1Fhezlq4Fpz96U3xDWnKTv2M7eKLWNxf6GHAbuKdEvMdNeMCCyx
	 ugA60B0FkjFYeoLrWEndRxZO/wVeWkzlfJgarpUirhj6mlNToCAXvdpfBahhnjsiP
	 +9yRrbPIqC+woUxKYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLE9-1vz0zO0a4b-00lQO3; Tue, 28
 Oct 2025 20:51:39 +0100
Message-ID: <24319a9a-ccf8-48a9-8b5d-3a846976afcd@web.de>
Date: Tue, 28 Oct 2025 20:51:37 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v? 0/2] PCI: j721e: A couple of cleanups
To: Anand Moon <linux.amoon@gmail.com>, linux-omap@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20251028154229.6774-1-linux.amoon@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251028154229.6774-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8RT/X/a+nAT87MaHyc2aytHhWPQxv6T2zFiD+0gY/7WIYB0Zmc3
 PoqVaPKjrDYY1TQQF5kNfefzUt+lVX7R/IXtBdKVrYMj2XntMLyiSRETUzyVppnqn8XsOsl
 15hS/tFNNsUPS3mem1fnW6xkEb3xsJg6J7BgT4RNBT9MsJ9nBH/5e7hY0WWs2jKbRlnAbAr
 zJxXj3uiVOsn1Evv/unCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rav8MSgGMSs=;aHTFPVET8EOMwSljeklGe1k//Db
 Tsl+Yk78nZBB1sY/PvQ4n2brE4pF+yZ/aznb319O1tDBpiRVc2uRqlHvtTE1shdcbTlwVRlbi
 MjHQlVpM03gs3uvXavrFTn6KzqofmLkKeaNf5mZ2Kb4UtZMljei2p3EmDyNlFvq+ufVRyg0QC
 k/QXjrUvKk7PuIGfyBWwlagFvfaLQKKrw8DcHINzD49KiAauIN+9+ZOM8xykYUKIB2CQRlzgV
 entZudXai55CzJg77Gn2Mc7Wz16nYlUQnLEgBpPAusW0UsGzVIIFTvn6FGOUxGchXrzOF+fb6
 UP8fJXocrmUyjk/sEmDmQS1mBE5WDrKpVPgU39mQwGOJxUn3VAP8ays0LSnuWrtwuhICKU61S
 Yy6bk63esnIa2LilHjVX4aIcewW3TPvBiJ3XuvTz9j3vHM2Bl8BMK9ZvoTMM5LJIADi1zdPtT
 AAeSqbL52i7plVyzw0ZVaRq7LvE1BMpeNY4LaSrEChO6xe9WMxfqujCK40E3eyN4WMAORqG97
 cBewOqMhMNgzwEfWOm2RabRZLGEkaEiXo8M/im80hnIFaqcTTYvX1mljdijfm3ibowA0674VT
 DIqYYMv/rsYP/X1WIdYne8LCa2j/I8HEM53QjuyVNV4daT32Qq693VSVyZtzFbGee8MGpc8/U
 ImufVlfOVVQPqe4rFsA+AiM0Ea9+bV5RpEShjKLmBkMEtQLSbmZpggYW2slwYm6gB+Agn1QeI
 T6B5I2WwWA0bwW75GVupJdmff1pOGS1Qbom1BQSo97oIKfGlp7GbPwlfC6KAbcQ37Mfy9/pON
 cskIBrR6WJfQO6LwpEE1twmfORTaHn7l6nawV73kLVcJ8kruvYa/AOo5uEVDizg0jbW5b3K0d
 HfUF+rV90ZLfbqcSW0DtZMRDvsr206KqPPwIKx64uMhHFmy4YzjhBBy/vMVDoXcOV3gtyKUxp
 RRQWjUpS9r75z/lv5t5SqZWG7o8XzZsTt62z+ZX2/WBdovdpJW66Ur2xnrOensmVOC8gcuoPd
 TuSQxHC2A2JQ9YG0GuZD92wWsz+EBvmwBFsL2ZlPfRfJATubJ2z+aCBVS42+AqwqXSqlJnei2
 zbNe++R46JY/vjAMCYw+aKzNQ05rbMqQtVzQ/wsnH+/CWB6Xe4bq+AY11Zbkf6MM+I/44omgr
 KI/InHY6eiSNv7xumj86CZj0GV710iypfzQVGoZ/h1JPa+Oedj49fx2l7YmkNAkM5dx/bjKUn
 d61dk/XJLsG0rCBYSJicwj2ccVN9vtOFq3TET+HZRI/pZuIMyfVJ7/yltLZ6AXiaw+mC68+AC
 LDEdPT2947VSgAnNsEduaX/VRfNKGuRULEj7SAazCfQI6u1RtxwZLVBnC66PeBwpnW/9IHMR2
 YubTnxfFvT9KNGI9e1a1rNRtLJRGegmbKsWJUr2CuRercDBAi7jnWWSsbkyGxmTntAk5ghY2S
 II+RuUGX4apLiUD6Nb0J85tnG1Sv1X1KmCFR4ZgVuwB3u/6uaC/jotfvh48M8Yk54+FIRlFTG
 8Cd9u4ubwAdH7gru98czwb3Ri6p181HtsnB4t/SyHSMq8F9wEAOBpAuIXc+VbiWOFKqrtud/D
 shqV4gAvfF/Bxu4JAmg4Rc7Meuu1UYmDxu3r7Ug1cVBfuECVYUOtLwynUxBy8aYUAY+zh4uRm
 UE69V/ByGPOaGQGsmRKnEkfgvGnxVGsmNRsLGG0PshBMuQw7SsRJkngGkshSNtvfCTrz2uMWi
 4A+INQgDToilzULayg/l63pHoKFJTECX1HLq+5y5ARBLJTYRzfrAQxbO0n5Q8/MeXV8M4FO/m
 2vS1ZZGf1YGs+FtlRybXLLrlSc6xb2hbhNpZmy6F2tFowxiZc3L6FlNyQd7WEOGzbHtS/VzWd
 4rBxsdJGMuTozyCfhjaC3oMkcf+ukm00gEyy3QSgjAFXP/PCpD19Wb3A453S07AEeV3vZ88M9
 3Ldu8tZ92tcsape7OMH3nDyYVmlmPgLJXLJgO+Mx5RLeBZSHLlWvnw44VGq0VL0tXcugHDB5E
 QdJIJStg2EZpECJLSD0CH7GVkLHgjQ6heznQsjcQ0W8TwyReG7ZfXDWV9aQcb/7pBj/OL2p17
 Q4VNarbNbGiaySD9UPBROT0y+tPMtxpujdUSJMe7vdA9lnNdHbIpiufPLtNj4miPUo1knk8ig
 UiHW+6Nq08qNvBTZNouu0byLZtnpz6HkqsrQpUajrSFv7PufTEzBSRhR3D/s113McUHsVZBAm
 LlsU6m3/IbgdgpQdcm8DmFJ5iW5IHvYL9l15oYbnwKX7welibv91PkHRRAKj4huaKiISWxNVD
 hPmydEHzFYh66Ug8y+yR3hkEtwTZdgIUJJwfAQRC7NBv7AZlgH8RV7ecCj9nHLIKl7sqjvBYy
 SJL4n6i4sEz45YMB88p8ma6zzWbhGrlu4et+5CVFyONwL/IDwEoBdNS6wJI1WF7JMc9bOQ3zd
 InqTZYSytEBPY79K0vjFB9bSgmcKuDdf1Ch3ip7nfcnZr20DyUIeLQHI4hsGiiR4snEhrNvDo
 2SLO8ssmAo6aBPt5C8PDIudqpt3STwBuLVAR6BKY5GNJyX9CNSOsU+yQkVRwv/NG2qfcz/ea0
 s+qsxv1jMc+QXLSmRHxDdR82NMZMTKx7PaUYuOZWPiJHes/SHV9DNs3nUZaOjbIbl9gvnLNxb
 gUmkjzc2j39kUgWmx0sMAY6nWBjZLaCT4oJcmOPDeLCoi2rcqZ9KkOGR03o8jHP2qwy6eJiHm
 m2lKDs3GEpUWFEVTdMNDDj0tIq+40Xs2WdPNBk4BKbQC3cZ3j/UuJYSu7YbyI2Tx2WRiuYr0g
 Bo8m0O5DwrKDs0RS5NfSLXmk96GAjKf84ERLZB6OVHMF8hLWOQ7ZXusmuy6jM4CVRzXuZt2Tc
 SMX5eVPNX04tnGC9TW/oGJ+QdBLitREpnliQU0qp204OGj5WC46k3FARn0raFQuOVxbh4fpi0
 MAj2H5IVOmRBHanSUVHCuEhK1Wg3ij76e9p06kUn2/Gz9rObUs03f2ApVc/6gRVANPt55dZy0
 3FccXSBBuS/sCGx/fJmVSQxkA1PAHYfFDiiSw0ssmrD/iw8WEovPjYoW/W5cBbMGSguu5Ufwa
 2OxAqP8bjZibx5Gbb757hGwxuOjNCS4wU9K5nUhmMlSMddwLuM8sq5vRJziPj3VxSOd3Lcgnj
 jFwL+yLJL1O6c2EkTda3GpzteSV1Tv12LGWDUvOUEr0bTFePpvJbmSyWKg0CSeqvmXVmcphKz
 Di+StVtBZKw4wQXiAdLyFu/T+9XrPQeYDWXm5qqbAJNcmkvBSWKong9Y5NsMnhfy+f5JbHy65
 ox14YVvE4sgS1/JUBcBGxl0NCALJnFiw+vQqf0gHhB97dvfyiz7wELICAtkFPOlwmrPxEVnXW
 RUiWLxT9XxUaBDrPlCnvchQBY/Gs+rA5E2JTL1/Au3+O85Gcr15mAM8wuCUNy8Dv0v9Y4Fc+V
 UXSGGuKMptlXfI4HwS297dbc2qdBOG3yeH7HyCwPM2hVqjuo8AvYM5zVCCqHg6luKV+xbnKYe
 2ZUHsGOWfCc42EYGMR7ediNdDmygSMiIww06DUXwaLGgldtaT/P3Tcv477UUC3v5Ke0kr5WI3
 fB5Pe+BUoQAB/oj6w+NKlp5+BioNqnNkmKy4cg7r0fBt4Z43poVR2xxI8U4FTgOfrtluCd8fF
 jJvyXtoINbe34LHPWWCzZ1NauK1FIgsBSxUWrdO2LE8/njDKQAcSI/fdT/W1i4XMwC18+If/L
 rOX/zoZVmLT1W82lpVz7IHYMSQq6w5PhUuhR811a22p3XyWXOhnwMIXKxgqu4WlphwHgN8mlo
 58ucxOsFapR6itw7cVGyfwqkteLCe04N6T77c0a8sDrqCjYqGMRSXI4a10iURpw08J48/yzLs
 MemdKdNailZTMaIWYCsJQSUHG1M5QEVBw/uo3vTIw2tYcV9kyAZLwn0o+UaS9QpQD4EWW0DWk
 /I6j3wEVruQJ7IC4Pcun/Nzh8o8W1zQZSbICnyX/KkVH1NDKDGrsxTFVjF7X9OKyi0lUWp75Q
 4SrYQ+ZlgtdLsvztf1Y8xokmEkpjlZedQW7xSvDYO2pmCHVTwb+d9hX8C7GdSWMcdumZRHAsw
 p1OWi+9QpFGyjGwKz5uT6+P/jubsUxCRG4M+O66IzmpFJFdezJ9RwMdZEpOxWnNiE0fPelXCb
 Q3/0YPLUcoF6DoYlrya3Km38gPV2nQwPI0HfZB9nDt64/z8/Fgo53u7GDitaoXdrq6GgGRSnS
 3V2QQO00bsnf12Q5PMkyF3R070PY+9eTVh6rNJ+DKOQUXgf/Z/Pjjitxz+1s2eE4skKChShN2
 x/Y3mgYYNwnIDbCP+Bu5p5zxyPtUCzMYR8yYTLS/XGnv6SCyI6pRdlFP6xTLaMEOdB+fWlyYP
 RIbfPnbHfcewzmFdweFkOujeTf5RJQ3jnzxdnPaBXxyN+CZ10QoM80nYGZecrBP7+IEqB8X3/
 l6RBWCcaIsScA2F+m9NPGCznJDp/K6wKtsIj0Bw6OMOKUwwpVFCnoliewOm38augqilxDxWKi
 nOVNyJbPvy8B8uiokCPzXPBqPrPhWNM5ggueA+r4XiIaW6XHWha3jzRq8PvuEqVxwViFX+Whu
 5y5AlXy5uUyHzY909xVfzsew5Aypkm3ieEadv2FIe6z4AgV6UrlB0sBVT1DxRSIT7RDP3Cuyp
 lQiF906WgClQ9kqWUSlHLxzDAhQbkyO/QkqzHG7LdU6+clnYaiulmciL19ZtSJI1h5HSWg1t8
 qaiS3D5CsEqRWRy3wN+pmt0J4y/RxBNZsm1eh6hFfRkKFQhkO74coHrwwJ5hMikU+WM2ETC0w
 kOdwIrxueBGp2+jZfgmglCVsjOt5pLKn1HNnqI8FKQuD/rg0WYcWxsfR92V3Z75JSyvC6NUx8
 hhxu6ucBIGxVoykYSRR5L9a/BrjnhFU26jPhlU8FfcSV/qV1ZSsjpmeq3JrTr7Cd3omOQquTU
 rQnHPsC8ZpZH9P9xzqOnr35N254jzbMOutY=

=E2=80=A6> Changes
> v4  : Improve the commit message.

Would an other version number be more appropriate for the subject prefixes
of this patch series?


=E2=80=A6> v1:
=E2=80=A6>    dropped unsesary clk_disable_unprepare as its handle by
=E2=80=A6

             unnecessary?

Regards,
Markus

