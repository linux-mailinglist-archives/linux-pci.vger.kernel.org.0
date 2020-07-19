Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F650224ED0
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jul 2020 05:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgGSDKX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jul 2020 23:10:23 -0400
Received: from sonic301-1.consmr.mail.bf2.yahoo.com ([74.6.129.40]:40823 "EHLO
        sonic301-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726390AbgGSDKW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Jul 2020 23:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595128221; bh=Zh8f6bORM80VqMgICWCij9HH7uxxBhlOlIApnEIDMwE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=C4mxOty0rogOvlNLcQ2RkTnjHB7KxivKUnuFVetc9P1aGcz5W8R/0GGmvBpS/1fLfbST3kb7WrN0UKXWkWJes62eUVEwQiUq6mFJEmw4RH2wiUyzNFhpac10g44vntdJmlAAHAdNMA/KXi6dUk1BO/a2Ld/tgH8X3m+e6/mzpTzJGmDv6yckRPPs7vqTYv2OUS25YHdj+Y4rL9SNn3KTvc68SEJ2Wfz2YFK2/B4raO83ytlf2Y6x7NxSwzdm9R3xN3+bdSy3QakcZpjbBpScduAjgwWct4m8nKIqXB3g0Su0fP0fAtLFcUgTD9e9Nhum84BoNaTbJsJRh2ddJ3sZjg==
X-YMail-OSG: WsxbFFkVM1lcK8gJMNYyfMohfJlQSAjV2ndqjvluKywGRoAAPRB6bCESKEfpA1x
 ultmB25NiKJ_TGHnODGQzQPfaElXZgaraBfackImW2x.8QHOC0Q7Aoejd5JgVjTDAcPqJz0cTyta
 Dw4X4E6uU.pXryKZyLD9hb8f9DfpsQku_wxklEpCf0jvSetYaNYdu3_avBt86yZkW_jL_h7Hg9Uh
 ykAMPMo9v2r78cupnzaC.vZz2Yp.taDlD.GZOJM5kBZdFrF0nHeY8dipJLGGe3FTC7PQU_inGamM
 k4UIaOyqkHfgG7_N5rkzLhUsEMHotPS1r7LEEPAQcjUQJLqernNJMocR92RbqRnfYERT7BKyiT_0
 17T3ogmxF5dYkP8HX7.XmjWcw7vdUibXrx5zX10vOGZ_TosLM3XEwNvZ3L6WSkDAhExNxgqrvALk
 gueGnpob_t13fPut36m32JKzQB7lekb4SaP76rjazfy.iyEC1ojHLpnLvJd.sv.V03AsazaP24AT
 lsOhXedUPUKEH7PEEiqNzHlIWleq_5lGYhVcOdc_.Dws_DaNDwC2lt_PtQ8EIxYAgjZI7o_sriIH
 JFPKKR.E4P1rTO9WutUOIEy.ILjvOVB2.CDNmqbblWkgYTkqRQOPJWHtvkXBhIBrtCf1SQZdYeqE
 aI3G9DIgIYzj8QPKWCG6bgn9Qjqr3O1jOJg8.QGrgAZF1kC1TeJWGgcclL2x5hQfYsy_oWJduSiM
 Ce1lXQh4cZQMw.rbiAYQKpyCPjnBg_eZKSAiSdD2I7J_KY4ZyPQC5eh_EDA3StgUMV1LF8cTiqyn
 VxPx8k_q_DbqGvZMV4CofIXMp7Owuzq4FBJz5P5ltNwgRdsxZ9NeMuOhowDYkI_ELV_zgSonNCes
 Sdgh4gWqEssN3gj6wTt2cgOllgAYwaZxgAGBtHdlpzT7I9Ko54I0JOmaY.XxREdGqZo4qnQl96Eg
 zaXlfQxogmYgHFTYtqc8._KtSlBEp.TO7EPkNMfWT4oUSRSmLMa82vhXinMn2..zWMrmd.ODtlgf
 EsbRz1jvhEAsYXgKD9PszUse7SIgyrsBY5aSS7r7g_gET0k_6Pf6NOyDBfGP2OBDm9w6.3QAPCt6
 kkZ3g_wiXqPczUjO.bMV15F1iz42oRozsmAfzeJcBIGyYCZUxPSEDZK9C9llqmEYiaXoLp8O7f.s
 .4ImgTNSm.w6fqkdk6p3hfIxo_glipBK2ZKyDfegZZQWGdAPc.RezJye5Wvhxzy_wVD2imqHs1qS
 ZiD1QqVGMBkPiaOdCu.pN0jdnYB8f2fy6kJ7K.Vp7Tm9vGytad6sFj8JOSXDQb_TnhpyOLMAJgrt
 lI9BHI0Kwge9CO4EMUEit6RzcfA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Sun, 19 Jul 2020 03:10:21 +0000
Date:   Sun, 19 Jul 2020 03:10:19 +0000 (UTC)
From:   Sandrina Omaru <sandrinaomaru2019@outlook.fr>
Reply-To: sandrinaomaru2019@gmail.com
Message-ID: <806099504.2673787.1595128219562@mail.yahoo.com>
Subject: =?UTF-8?Q?Ahoj_drah=C3=A1?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <806099504.2673787.1595128219562.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ahoj drah=C3=A1

Viem, =C5=BEe mi po=C5=A1lete e-mail, aby som v=C3=A1s prekvapil, preto=C5=
=BEe v=C3=A1s pozn=C3=A1m. Pros=C3=ADm, je mi ve=C4=BEmi =C4=BE=C3=BAto, ak=
 m=C3=A1m z=C3=A1sah do ochrany osobn=C3=BDch =C3=BAdajov. Je mi pote=C5=A1=
en=C3=ADm kontaktova=C5=A5 v=C3=A1s s podnikate=C4=BEsk=C3=BDm z=C3=A1merom=
, ktor=C3=BD je odhodlan=C3=BD zalo=C5=BEi=C5=A5 vo va=C5=A1ej krajine.

D=C3=B4vod, pre=C4=8Do som v=C3=A1s kontaktoval, aby ste to mali z d=C3=B4v=
odu naliehavosti a n=C3=A1tlaku, =C5=BEe mus=C3=ADm n=C3=A1js=C5=A5 niekoho=
, kto by mi pomohol. M=C3=B4j neskoro otec (Omaru, b=C3=BDval=C3=BD ministe=
r hospod=C3=A1rstva a financi=C3=AD Laurent Gbagbo a zomrel 11. janu=C3=A1r=
a 2012, ale zomrel pred svojou smr=C5=A5ou bol v obrovskom mno=C5=BEstve os=
em mili=C3=B3nov =C5=A1es=C5=A5stotis=C3=ADc eur (8,6 mili=C3=B3na), ktor=
=C3=A9 tu boli vo ved=C3=BAcej banke, Ivoire. Zriedka bol ulo=C5=BEen=C3=BD=
 v Slonovine, kde =C4=8Dakal na pomoc, tak=C5=BEe ma neve=C4=8F ako bud=C3=
=BA tieto peniaze preveden=C3=A9 mimo krajinu, tak sa odtia=C4=BEto s=C5=A5=
ahujem, aby som pokra=C4=8Doval vo svojom vzdel=C3=A1van=C3=AD vo va=C5=A1e=
j krajine, zatia=C4=BE =C4=8Do vy m=C3=A1te na starosti investovanie s peni=
azmi.

Pokorne h=C4=BEad=C3=A1m Bo=C5=BEiu pomoc nasleduj=C3=BAcimi sp=C3=B4sobmi;=
 Mus=C3=ADm poskytn=C3=BA=C5=A5 bankov=C3=BD =C3=BA=C4=8Det skuto=C4=8Dnost=
i, =C5=BEe tieto peniaze bud=C3=BA preveden=C3=A9, aby sl=C3=BA=C5=BEili ak=
o str=C3=A1=C5=BEca tohto mosta pre siroty a st=C3=A1le ve=C4=BEmi mlad=C3=
=A9. Ak mi m=C3=B4=C5=BEete pom=C3=B4c=C5=A5, som r=C3=A1d, =C5=BEe v=C3=A1=
m m=C3=B4=C5=BEem pon=C3=BAknu=C5=A5 25% z celkovej sumy pe=C5=88az=C3=AD a=
 5% na v=C3=BDdavky, s ktor=C3=BDmi m=C3=B4=C5=BEete tento proces previes=
=C5=A5. O=C4=8Dak=C3=A1va sa, =C5=BEe na v=C3=A1s budem okam=C5=BEite reago=
va=C5=A5, tak=C5=BEe s vami budem hovori=C5=A5.
Kontaktujte ma tu v mojom s=C3=BAkromnom e-mailovom ID sandrinaomaru2019@gm=
ail.com
Boh =C5=BEehnaj
Needy.Love
Sandrina Omaru.

Je n=C3=A1m =C4=BE=C3=BAto, =C5=BEe som t=C3=BAto spr=C3=A1vu odoslal do pr=
ie=C4=8Dinka so spamom kv=C3=B4li chybe v sieti, preto=C5=BEe tu v mojej kr=
ajine.
