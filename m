Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8928A5F7
	for <lists+linux-pci@lfdr.de>; Sun, 11 Oct 2020 08:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgJKG34 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Oct 2020 02:29:56 -0400
Received: from sonic315-18.consmr.mail.bf2.yahoo.com ([74.6.134.240]:37885
        "EHLO sonic315-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727181AbgJKG34 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Oct 2020 02:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602397794; bh=ErQnYVlC2pefuSTpOMCm9/XUNMjj9rhfSqCUwkKhF70=; h=Date:From:Reply-To:Subject:References:From:Subject; b=s6oerP5ldQUDUggx7rZD+Eer0MUx2SzvDB29cisL98NWmsC7Q3Ep6iGWiUEz081nKZrbf8CclZtSuGik4aCcUHxxyIwaXUEhiungrRfQTPDzbwP6/l9hJX38ZPUz882YVRkrAkg1f0y9BkyNbwUaXQpf9AARp7i/BER9n3XOQaVXn59Jg30vAE4G1T41WaFfNr7n87hPGFBRrIL8gJzUPX1xyEsk4IfEq6cslUTG9zU3eRhEvj6jcbHqMb9nRFEpLCTPP0LPLKZ+1XveSJIIVX9fRSocQ2B8vm/RAkm48EzjGlDidAabOtKh0FFXi9ExJQE4ziw8az8xoAsoASi/Kw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602397794; bh=qEGKYkqeVABs6Ve8RhhitEN49HwhG1bJI03Vm3Qlluc=; h=Date:From:Subject; b=l2V7oQ2TXKTMXVsAnwzs8xahrp0Esk9vf1fKGOFj3Jp6ktUjC2NyTdc8AmZZH6q6/vDFYtTg+zOkhTweoYNEFVZ8cRe2TogFWXbSXIMU45Jiu47xakCWdzg5dTyDZqIxnEwLHb9tE6rs/yBqkQE/rxTdOkFBaFco9QdY4CqOmwWsbmAXT5HfpR2yWRTcMbBp7S/AcSgiwiFjnPGr6r9y51TIKPF4GWA2lAMGtpBCfbYCFDEPr0HZWJ6vRTx3qoJ+Yn3PonQ7ulnPatbORTvEWTL2X2NzDwT4GhmwaoooHt+b4DI26iPLUXqzhNfCdFjROy6UslnsvMYyWIsUiz4HMg==
X-YMail-OSG: aNyyEXcVM1nG2l3OPsgBq_SmJtwDnIjTC7xWNhZBgAWJDpPOsnAP5TFw.bUKTaR
 aUqfjPdR3wXejRukItWtgUyFabb6w7gJ2iOA5ah1jt44iRadC9qOElYPqT6f5Uu6XjT7vcmFbZvC
 8csgPEQs1fCXfzhaUARQI7j1VzjWdcuY7IA35S7gWgIgIZ03y89aJIRLIFf73cFPhze5NTvQchrO
 ZGA1zOK6HKUMfmWO3dbmhpkONzDSFmvRAhOoMQq7OXxSiHq5JFmhQW.g9dR8bW7a5QoMx6vktftU
 njGa8wLxCYZmyUbG3__sLW2v5gVsdVWs3EPAKOHNsHFcH6zDHtCetXVbWu_bmoS1oHAe2wIhfGUq
 8kbCrKkUC161tCvBXaYSfvRQcWjf9pt.etItu3yvDpy1xsK9YxVGsxoJMK7Gw0a.6MYkcszABdFy
 lCLbtWBxDWSi9r4GkgRQFl.VFjxt4Hw7dARqAp4UTvKEJ33_80dOP2iJWyk4MZbRBSsH7FpjK9oD
 UzGjei9iZoxxbVUkH.QEw68yv2iAF6gdmqOAXFn2QfMiuVWZhw1rIvkdXGq.A2XyMZ9TYMoC.XLy
 ggHNHrsRMPtcZ02RfbfF1yERJ0ui0iFs2H88yWD5JfhENicNmvuom.6_aQRKKvtrRFdi97NjgY0Y
 UX7n0pu8zzDSWKyqcv0_bumSnLaK6AMJPM0WwGL_fLH79xC6PVANN0Lsl2HaijPwe74zFLEsotH7
 aAe3B3tnSi79N4j0Ds9ozFNozKuwA9wFXTUdd8um_ks4bW5ZD52RW.Td5kPbP8LfM5hAu.rlNpIh
 xoB1YGCTYKrxT5U9vBxCBdo8XLyJZvYWrIQIXDJFQnu9meJIabxKwPkNLR52mSwlH3O.hhBlHuxE
 u4g.XfbVVdmRQg4V4ypx2SWNRTEvIrud80pSkJ_LnWFHkB9w_Qi93PAhajx52vS766nZ3k62Ol8u
 9u9QRe04rZtZd1_OlEMJllF7p5TToJbEqerQmjHGlXuCKoZGAd_Qq5BM3rrX9aH37gCVXdyWONVx
 8BQUqhXFRG.NAAsJB1VDlRO06t098m7SUHFmh7wc8gpsZU5p6z_z7Xtl0Wf4U7ZZIZ1vjUMkEDQr
 vThoimau8HEng.Txbb074Vl9G4p8GyxqmJRXN4klFFvTsFAo7PFOTjgF3AbG3fAgDonqJwCNkiDs
 i8hodl8qcg82ib1nmjgNwuUZXulDyTVw5qIRHSmIGoQTp.G3FXrEuTM19f5kmqJ2RVaNDCYlVnrT
 O.qTd.dih.978GHYczAMLS.Dtx9wGKS_Q6Veu1nrlVN1xuJvFnIgK4tkv5YqfSA3TWuWWxdoj78g
 6lBpXfpzL25Lm8ObkwTqyBBy28UeCNc_NnjOMlvPcDcI47SCZ5ywxAGjGnJ2wjUW3ZLsgRTrHWe5
 f9jRd63vqy9DW3jbDqRAuSy5GayHkgJT1mVbQ7pMlut_pGW2ZSPSwBPgVQZshpu3gdBNtHyljHTv
 HfGh33lw_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Sun, 11 Oct 2020 06:29:54 +0000
Date:   Sun, 11 Oct 2020 06:27:53 +0000 (UTC)
From:   MRS ALI FATIMA <webbox23@yckot.in>
Reply-To: samanta123@bsnl.in
Message-ID: <1101613109.170267.1602397673202@mail.yahoo.com>
Subject: PLEASE DEAR CAN I TRUST YOU?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1101613109.170267.1602397673202.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16795 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



From Mrs. Ali Melissa Fatima
Membership in Turkish Parliament Association
Tele: +905356520176
My Dearest One,


Greetings to you,

Let me start by introducing myself, My name is Mrs. Ali Fatima. I have been=
 suffering from Breast cancer disease and the doctor says that I have just =
a short time to live. For the past Twelve years, I have being dealing on Co=
al exportation, before falling ill due to the Cancer of the breast.

My late husband, Dr. Ali Bernard, a Retired diplomat and one time minister =
of mines and Power in the republic of Turkey made a lot of money from the s=
ales of Gold and cotton while he was a minister, but we had only one Adopte=
d Son Name Ali Mustafa, he is only 12-years.

later, my Husband realized through a powerful Man, that it was evil course =
instituted by his brother in other to inherit his wealth, but before then i=
t was too late, I and my husband agreed that he should Remarry another wife=
 but our Religion did not permit it, Before, my Husband died as a Result of=
 COVID 19 at the age of 89, he died in the month of April 2020.

Please I know this may come to you by surprise, because you did not know me=
, I needed your assistance that was why I write you through divine directio=
n, it is my desire of going into relationship with you. Before his death we=
 were both Muslim. Now that I am very sick and according to the doctor, wil=
l not survive the sickness.The worst of it all is that I do not have any fa=
mily members, expect my little Boy but he is too small to handle This.I am =
writing this letter now through the help of the computer beside My sick bed=
. . When my late husband was alive we deposited the sum of USD$30.5M (Thirt=
y Million Five Hundred Thousand U.S.Dollars) with Finance/Bank Presently, I=
am willing to instruct my Bank to transfer the said fund to you as my forei=
gn Trustee. Having known my condition I decided to donate this fund to chur=
ch or better still a Christian individual Or a Muslim that will utilize thi=
s money the way I am going to instruct here in. I want a person or church t=
hat will use this fund to churches, orphanages, research centers and widows=
 propagating the work of Charity and to ensure that the house of Orphanage =
is maintained.

As soon as I receive your reply I shall give you the contact of the Finance=
/Bank. I am offering you 20% of the principal sum which amounts to US$6,100=
.000.00 (Six million One Hundred Thousand United States Dollars Only) and 5=
% will be for any expenses that both of us may Insure in this transaction. =
And another 5% will go for Motherless babes home. However, you have to assu=
re me and also be ready to go into agreement with me that you will not elop=
e with my fund. If you agree to my terms, reply (mrsalifatima67@gmail.com}

My Regards to your Family,
Yours Faithfully,
Mrs Ali Fatima
