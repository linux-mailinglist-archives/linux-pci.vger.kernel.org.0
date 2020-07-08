Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AD9218ADE
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgGHPMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 11:12:06 -0400
Received: from sonic306-2.consmr.mail.bf2.yahoo.com ([74.6.132.41]:34751 "EHLO
        sonic306-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729500AbgGHPMG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 11:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594221125; bh=Uv9Il0GvVfNf8ySja/n2kkVJo04KZ3nX+ejOBNQOQ/8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=uOG11/yy/huLJscmf7MOOhElAeJKPOShBJjwL/TF7uXnNFuEiiSO1/4RR/pgCIxVUJUgbZlUmD6c7rfEKSY4mGDahTGImsXRWqcVybkKfFWIRfbFTk5OemPalZU05pqnXxSgZVRzk6Wf6A4LgYQuct/918emnicwRoI/96jpqyGKywwQ2GlZEvVm5VylecNUV/wYBv96KtT8AjVkhqrsnYslytq+3dbOYi+gnAGaVc7j8P9EHCZK3ILx/lmiNrL1GEF8BACxXIfExN90s9al16gEgelXbMDI7SokEeuSlxZEr2dZfsNP2Dj7ho8q6jHKtG3QsYahlneJNW/2ej9rQA==
X-YMail-OSG: ezjof1wVM1kfcruk6hQj4mlKi_8i4JeGC6Sb3IlD0qNmqEZpivqc4qFV_6XQIbm
 t2jeqztdKhW1Zf1x.S6yyEOGnu8ToAnyAC9AshkgG2WXeuepjx1ctyTZeOdj3fWhaZgF3vtzc.mn
 yG0HxaFVsF_ADXj2v5UxTnBaJZQxWiFkMzFVz6QR0U9iCQEFesdSrOp6tMC.lEgBQfS6ECReCw1h
 aFWg5N4j5Id0kAl5WlUnI8MIt6_nUBSKsTxxJ6wqPKOSjvP8RGNc6DE52CzHj649zgOTFtXxtXcU
 B2qdKLqCkCtteVqmmavM5pR4b9im99d38HA3Vic1UYkIO1OFefqi09abizoABgAzPIVTajL8K1xG
 4.pIdvuiTApq4C6QCKC9Hsxc3s1zgG_gFutx8pqYaIk.WDWrwwm0NPD7ZbQ9JzCngunm2V6vEJpu
 hJkbEMHfLEZxDpAmTyp1vW5hgpgSXj0XCQafEpDLxoTfzZdkDozgoBlCsRbxMeMP2CDgyuo49yft
 .07RgTP8TEgl.6Do3EHhVeQSZREn0cHdOmaPcIp8463pxlgYlpWFzUk4M0zKJmYNIOmAHEdo0qfW
 ymPaqKYO_EPMKJe9LCC1oTVmMRm3FbpDPtUkbsCPpbV6xIaOSjrSFAeRlJKIppTSuASPeG3Q7I2q
 cvjtSZGMzxM19xUeP9yB8JegrzOLjFW55sRflTKLAQWy9dXn214YSE0odH9ENgBz4rUaswr7P3gW
 o2umE4kQL2NkEww2khSHv7N266unRfaxkKKlMTqwMnX1pYsvMZT2LHOUSe8OE3pKURv.pUa0EN4Z
 IfHtQ4QtCdx6tddOIUgZQzMxJc7oDk6umEGJEIy.l8W3ggc0M9vD3b0PuQLtXIyRdg2zE2EL8_ZX
 YnyzsNbFJUqh6gNv08rEZ1l.3dNJB5nSXPs.uyfCh0scPuuOy1qMhN7Cf9jDdCefQERwuMVC31yS
 2WwnyMTxIgivjBXUhJ2CtR9YMBaSpr6JA.uD2GQm5KBJSYINIk2Ec1D2OoFXXv9Krxoc_nuiUVHA
 Dle2_FVFz6YzdWvspft.QCyZj15ZhJ9qmNhuVB2Gdfx9N5Qb64v504KhFe_mLloik0aBo4Od7O.K
 5kasmzp9RaiAACtt6HoDYMoVWpqwTPyjiZro6VdNwzaYgpNeRlRRrfRSLp5_n3wgT8MRBGJ8.iA7
 W5T552p30rYpSoVm66DngVhBS59FglYAi3LUVHF7Dzp6M17hGNh6gdKBfDRcAYhcuuPVU6zlGyju
 agZcxL9swFdIfKEn_QhLjO991aMKvdcc3o_OJNRoqf5h8cxU1SB7Nn9onmP2Oqy2fapI5phLQug5
 5Ylwc5A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Wed, 8 Jul 2020 15:12:05 +0000
Date:   Wed, 8 Jul 2020 15:12:00 +0000 (UTC)
From:   barkummar faso <barkummarfaso@gmail.com>
Reply-To: wu.paymentofic@fastservice.com
Message-ID: <69818794.2153454.1594221120675@mail.yahoo.com>
Subject: YOUR GIFT WESTERN UNION PAYMENT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <69818794.2153454.1594221120675.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16197 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:78.0) Gecko/20100101 Firefox/78.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



ATTN;BENEFICIARY:





You are welcome to Western UNION office Burkina Faso.



Am Barr Kummar Faso by name, The new director of Western Union Foreign Oper=
ation.


I resumed work today and your daily transfer file was submitted as pending =
payment in our Western union Bank and after my verification, I called the f=
ormal Accountant Officer in-charge of your payment to find out the reason w=
hy they are delaying your daily transfer and he explained that you was unab=
le to activate your daily installment account fully.


However, I don't know your financial capability at this moment and it was t=
he reason why I decided to help in this matter just to make it easy for you=
 to start receiving your daily transfer because I know that when you receiv=
e the total sum $900.000.00 usd that you will definitely compensate me.



I don't want you to lose this fund at this stage after all your efforts. Mo=
st wise people prefer to use this medium western union money transfer now a=
s the best and reliable means of transfer,Kindly take control of yourself a=
nd leave everything to God because I know that from now on, you will be the=
 one to say that our lord is good, so I will advice you to send me your dir=
ect phone number your address,country,Pass port because I will text you the=
 MTCN through SMS and attach other information and send to you through your=
 email box, Sender name Sender=E2=80=99s address with including all documen=
ts involve in the transaction.


For this moment I will be very glad for your quick response by sending sum =
of $25.00 so that I will quickly do the needful and finalize everything wit=
hin 1:43pm our local time here, I am giving you every assurance that as soo=
n as I receive the $25.00 that I will activate your daily installment accou=
nt and proceed with your first transfer of $7,000.00 before 1:43pm our loca=
l time because I will close once its 6:30pm.


Contact person Barr Faso Kummar
contact Email: wu.paymentofic@fastservice.com



Be aware that all verification's and arrangement involve in this transfer h=
as being made in your favour. So I need your maximum co-operation to ensure=
 that strictest confidence is maintained to avoid any further delay.


Send the $25.00 through Western Union Money Transfer to below following inf=
ormation and get back to me with copy of the Western Union slip OK?


Receiver's Name...
Country.... Burkina Faso
Text Question..........Good
Answer.............News
Amount .......$25 USD
MTCN............


I felt pains after going through your payment file and found the reason why=
 you have not start receiving your fund from this department and ready to d=
o my utmost to make sure you receive it all OK?


Be rest assured that I will activate your daily installment account and pos=
t your first $7,000 USD for you to pick-up today as soon as we receive the =
fee from you.


Please do not hesitate to contact us again should you require additional in=
formation or call +226 74 43 41 61 for further urgent attention, as we are =
here to serve you the best.


Regard's
Barrister Kummar Faso
New Director Western Union Foreign Operation
Our:Code of conduct:1000%
