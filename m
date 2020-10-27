Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC929AC2E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 13:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbgJ0MeY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 08:34:24 -0400
Received: from sonic312-20.consmr.mail.bf2.yahoo.com ([74.6.128.82]:39783 "EHLO
        sonic312-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439480AbgJ0MeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 08:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603802061; bh=nz/cZ0jcy6Ye2I/ONPIEKE+LZzmQhr2u1mDnKPZa0/I=; h=Date:From:Reply-To:Subject:References:From:Subject; b=DVvw1fGn7lViw5QmSdx7u6+7DPlNllrl/Yv+BeZ8XQ+h9TLmeGzOHcEa0dcX+uNXvG+9qoz1wym6bKru6QZZG2eARmSIYeMOnc0mqmvjJX/1kcE18f1aXRZaOWJ6tenp1cSt1v/JkxsPIGy8TDWUN006iKNVb0QhZD31Gli69hPWozb0rrUzSDFdyCNYroy+wHXmHgRiekv0CPv1e8npw6iqDQilIMjqABq4S3A0zlRAWcHU4Tjlg3GcefISPGhnrBaU3k46ayna5siFJr7AgI0eaDPZcgYv34crsddfPomdtF/BQtPOsIHTmZp3auExq2uRV3Jbu9B3kSCozz6v7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603802061; bh=0A79jNIU43J2w97m5pzqg8lzYv+ZGLudJ0OOsrmRKRj=; h=Date:From:Subject; b=MnCoayl7asCXu8Jh6RBWuOW0w/wIjrpWHlSqzW0sA0o5GMVGYGwWA5ZKXs8cybv4suImGf9l29/3XHTDkAfm0SYXTBQBw3qBBF3wCeC4SNI1I8UzBTrshKim5iZDBjf3C8uKG94aP8E1FxwgVT8YOA8BT1jx44w2pgqDTBNCgMcu0LQ4/dc2Zv+DfEHw+lAhGY69VUdMPu6j+tXGyaXENaUxRuCKHqNbJ0+dhVVKGTvqgnfDTPAmjxjvFzxOQl2sryjjNfVBCOLSf1OUVOKX2gJHOABa3segdlZFkaqbLM6rxDYS0+5dprnlpUOg8vsF6BXJgnYzvixA5tvgWBVoIw==
X-YMail-OSG: LuIFAlMVM1ky3irb8X9yNHfkg8l0TqO5jPCsvpLp_MC40OVGJZ_fjA82oSCBvNE
 2piPNBuBqUx0wFjRqlVK4FG1nT.YCsVjx6DgCYceE_46VFmcUOYju9Ftl1kFgNKH1F_DT7SN349g
 k6n7KNitcgXHeODQzgsqw_ZfUiY.1rkGHMegU6XF78dZv4lvajGcn9heiOFzlcaWGSJDbMlF1kBf
 .ZkvKqyS2SgnKCFRbTATOuNLg3geIopunfLeZdilqfNdVM8_xmWfnpiUL8p3yBs4mXTZJWct9CLs
 Y.0rtzdt6H3zPTRAaDszHCsfQGOEoNLZlQYgeWu4tyrzHCQu7egWZVobOgBv3OGhlN6I6qVb7NyK
 32rGXDGCgSZGeLol6h_JcXrz_V_AI7FI3KobHSyLECqcqDlv9fR80hMbZ27EH3u6tTZraCMR.wS5
 Le9mKD1onbM8SYgrnnAQik8kZN0U7GrdCkpL1JOVhhz0O.ayWq1cmcbI0s9qLpgZ8LNf.iHUqJ7O
 vdDEUJafZXf1bc6XDQqoz71J3SyCkk1ivhsGbv.pqjLWjpdvE1YFOjzWELx2JCJ5Q9u.a8xKHgsH
 nIiQEqYShtVBdyv2zMlI1XmUBc2ivoq_w.DR3nSGW1ZnxmmIAk8st2pZTh39vevRqOVnoPpa40tk
 iDTDY5Ht_ZiD7lvanmrxk_7C_htd8vTzfez7HT3NAzouP42uBdO_Uw1Arui_BtVuQPtJs7KodjoW
 kDex.cWlyArc7H5aSsbNKcoimGYfigXA.frz2DDkebj8r7wrbk7NW62337_ebCyefiBDMhLkiXuP
 m6CLPIrPo2idodU0RDyGqbBZ7AXaJLPM1z9y0OiLDBVwkp1V8huZFFlZja8bmKo_Mm1H88IxPdFp
 1pv.NPI7NOKGiFlHqAGxq.FroA1UQOXZ1nV.KU6Bi9VQg1FSNvmxwuluefwNb_mzzp1TfEbvn2YK
 KWruQ5_QOBGrUzP0XrMinb_OlkxQCx0NpN9mE8yGNBPPfgOUwuHEEyTkAB0LuQjoMfZMtilEFIWa
 q.I94B._Q4EKY_Uyn7BTaouWzEm0LKNc3IAjrTp74IO6KS8sLWdtYg7kG1AbAN2Clx0woeQ8jl5F
 lN_yt4wajNk9lzLC3yZLKbVGS4aYJZ5Uwna2fET01Su4Bp0zcjQI0B_u94EHgxaxEZkLqKtmHQ2u
 1YeasTBK0xXtUj2YsLx3ScjjOKcibAiW5jcg.82lB3aFJtdmDFxMcCS5QYp9bBAHZzGU8yHUxut4
 Hb.CpkKyhrobkH7fVGz4EZomDiTom4CG4LNP6cfnqxA9zZS.v4ZfZQI2mSlOF0op3Y3fGjIpxBrU
 qVc6xH1v76AJ9e9KAqn6kxzIEGHqPAEz2XntIZ1lgtdQekEcA_RTvhBN2Pt8NODGIYvVHOcQrWFX
 dUgM3CCoV5.W_hD84b8NtB5VU4P0P4H49uDgj9qrZlvYXdI953eAMLWPvg3YHYS5aERFr6jVjRjU
 f82wJuBZ4Mx84JynxpGMHtoEhO2.W32P2Hfi6X0tLKvYVjOmnrntMayJOEt78x7HrelZInDqIR3Y
 aLFUQX8j.sywirKkW3wg_PMiHWHKU5IEHUnJOf2PFWYiNB3kuJJCYIKTa5wf.4P30.VDZx4veL2g
 7wYNdsw.AmmgkPbltZtcbhNUIlKnoSkSN7Qp6HKTrBqpuZJys1jo1PyviIAhJl1jw8ap7TfqxCUC
 _Y4Zu7mIwZIV7dXlSOgoMf5CUzobNlTEuNGsEpwGmX.qK2r3MYWpIWcPhoV4vwKTGToOXpBOehhl
 OJ.zO9yfDbFCn7dAv0N_woVz1Nd4qGaxSvmgbuwuJZVcz28XcUWgCZjZWEsNRTLQMOkRo1QySFfA
 lpo.8zPllAD0pg3yrQLvU4QxEKSMRQtgc05W1TKzeQz50X.p4ogsgtrTcBfPCDdzNAIEZygE.9UA
 9Vq0dNRbBGxfRNrlIMRA.2w_knq3sX_OyWh2cvf5MfrEc2C5H.x_V48izyUON_rs6stFLPmFguuy
 DzUnRQeh3mDwzWNmgSb50wE5L.iwlLWea06p.Qk2QpeWIUfDVE7jRzEUzjNDujbClObzcRUhimgs
 4vp_IAvRT0VlHb1Nlkkkz61eQSw0VjcyvzWlc9IKbSqOtlqQsIFZF.BUJlH.dWEq.tDxOiKndGOE
 l4iRh9LAW6WFKub8O0AU5bsZT.wA8nxqSV294Avofpl97V8jB4cfHhdSkfMvgbGSZfMu1DTf7IuV
 AfPSiPamBLD.5QQ1Pw3jLqmpw_l.R.OArnc4yHARKiw9vO9PAkBzlgRWtyMCY7HyD4sP6rKcWwAl
 HZtaTMJDHCkIb9pAIsGe2iDKnZEPCdCukREC6S8HehR_XWf7nLUp2QUbx6pxosiNf.PtUyTgfHmM
 yIMB8pHouGQ0.v10qzohfRei_utkStBSG9c_gfODM62.EmCzkAIO3wy2fX6W_pUxfD7x.O9LxdBd
 10bkIIVOcV00C17NoUNRgb5_qZZr.csWC2UcnsnnmzdvvKaIPTuSfC6wyinrlYxgnETPMt5dAIFH
 iD9RiE3SCmLTUGyNt_0KqFNtWb1C0uIl1Q1cI34WQNJvBQnkirbMimzays_cEp6wzLMBwSxljCTJ
 4AV_Mdfn35GqJcAOVtcXQe_akZr99Ot4zBbkqosGdb.gmJCxzw4bWKceazwQF24ZbNu1kR6dl06m
 gpOxdeH9qVfwluDKLUgFyHgeAWjXDiIXQWRRzOP8wIkyyQI1E3M_QyxXjkb_nhMMiuVBe5GCrWWv
 Ph9i30bSIrhkg8WrailpwH7AV0anzOnPrmpPh1b7NuoTXVpBeYa.W1wSpIRamx_ZyTS.znjz0i0f
 tJv5_Q_ZDdFNLAHu6T6WxqpFUJRLSqP3WYCOFC9e1saATeZguYsieZsj3hrWjfQJyGCt9E1OkqFi
 qx0y5P.lX6LhmFGGBxu_X9ht2j21P15VsdZYmRrlsQFC8e9zKwVSVRc3T9nsbDcT_iOhXNkDKfKD
 B.AT82FT2qDHxb9UI8AFV9W3DT2xQOCjVAxiRU.SO.Fd5PU83mKNhe_vNMk9l60uBR8YqTV72LZ6
 goVqXvDT9tgchXmlYAd7OmRbhTGMSGg6K9snII8sJYnyrQaxgTsyA0nwfWEFj2MHCdGKDFVsuy1e
 YuZaVxkoQ14NaBX.dUU_qGzY6opsyfbDPQXL7lSka9hVeMuz5vf5.FSbETDsBiZGkKJiOrJaAnTe
 o6zR44LDpUcrYvn.OdQioukN5YaitWeyeGhGakNaFmwUtFS1mw7OhxjgjIwL5lpNYBLSv0_jN_NX
 9kPSAQyxhjFXU_cyqiMHIewdbT5F90lXL8A20ZuU9LfrLBcgka3mxxNpL0ULobmx5LRXKRX83faj
 0lULp9GV0iZkDYjrVjThf0CEXKb1c08tBMAUROjKj3kOU0ikDEVSzZBdegg8BKUDQ_QDNYQS7z8w
 MTIqHTbCtawcqmB2YyiNTB_OSfNPZRxRxwDGBxALfmfU.THkwgo0m1spIGZLfUORj1ua7KQT_qg6
 .SOGNcUM5Qfiqpwv.tTSWgiX00zjWse3NxI3jNHrWnZ_tYP4xOLmrQENbIesinjIphTFunzTE663
 c4Yeb17QWIpaYSq5B3zcXqCijIwanZkyjAXpHRVK0RIw0hgL5DC0CGqu6UmVCS3GSnmMLk5sKMxv
 Q4eTDqlmMqn79CDCedW2OvzWTmOerTkao.BreycG2sunUrsVyvTX_iloILw32MYhiG8WGTlgICHb
 _rlYRxS.n0pf6cjU36FUy_OHC9s5fSHzjluzzsezI7kWshBwLD5xPt6fbdw9I9k9ojl9PBPsdU87
 uWvT7C709uGn6kNMtBlEZ6_zDqewB7Us0xCupPCy3ecyVCuskky8Z7MC11eetSertijKYPw13Gfw
 EOB.icjsbT.6QIVKMtw8T2cxqJ1RAbXRo65sx9AqQlRHRuV1QRj4J8YiNUnDEP_TGN7D7fZcvy9V
 4hF5mJ98th00DcoSckiRKawrS07M3FtPa3Co5cSQTjNT._G6S2uRu8JRIOq8WmoOG6rzssqh0niW
 ebqqE11GaOjfHawkJ13OaYsd9lCl53xAm0VXOQCMvcM_qC0cbI61bnOItYxyErJOhrR8c2oI.Kao
 qfkEGXI3TEiwngFRX4oJhWBG1tgkE4kLsoCPGvce4_aK3RIeZpCsojkBJ5t8wTw0lZE0ax6xEx3K
 Oghl8wFf6EdZ9rsZ44Puj.tKAg.6Fa9T9h83FhHYjFitMN2OrWZYIJI.Zi4VO7CBB_TgjC1m0nra
 0AtsJYHCtBzug_4LDVuelDWgMIvMLyMC.YMbrytdW98dJo3gSM7bSc6NgfMmJsJAfhcylltLiZcc
 7AMTshuy5qgaZZJwdvQxHqz0uHycgfamF_VofkxJiWMDemHdKoGS4MutnHO3Otmz7Lg3g0NowIEQ
 NDO0HKlqE2PBc_mllF_7LPSE_3e8chp6Ty5CLpuiSBccuo.QWbsg8lCbyH5bKd8cVF.c2SJmXjYk
 LlmZ0L8rmMjsOHY4VbjjoaSk2gxAQUVKv2dPElEXngcA6wuSQfOgj0xK5n5PUD.jlKTl8IL3WJaR
 3D3oREUfZyGcZwCbSvJT7HX9Zp2BmYr4Xo_XVCxyY09ZiAQjMtIao86znhge53eGZ1JlxluRlBDl
 OBqF3sf8ktjbCv7t4cDUldMA2Cc5A5pE.km_YD1RHx1V7sSYAk6cwFfSPEWUnXam3jm5fHmkzyTk
 DKjmKPt4xR9gOe_z8g.VMxxIZQceYDlt0fb1R2odDrzAOGNzm6cXa7.Fw79q1GxROAly5ciWhVyR
 xCNn9VWMmqyY3DCPS1jVLEJO4cRKG1bSnPEjZsNYi0X0.GOTMihAO0MvZoeflB7sCEr1mvmwfIoS
 N4YvCj4lHBgjUW_SBCNWEDOJt.4gdwpoYS7RLU.QA.Rnxu3atBWjDwI._YeJtY1kBx618mr4umVs
 OgPigyxZUNg5CkSFg5JnkIpLilXyN6zn6P.uMf7iKX_C62qyfro0HuQOjflN2YTwLkPomXxRA3qO
 SSbdJ2KUGYcSBGFyUtbLqElVqOesxbHzxU4CXr7AaRvLO.zxxFf7e3QnUq5HGEsB7qnaCmUULEw3
 beByGvPP8T9JysU1b5ujOOPfkZNr5g6Dz2fFeH7O8PIN1_mfTAir7LPOdYtlp6hbdAhMR3fWxZSx
 2OwAZDczna8gPCe7qpPqUJFga0u2TFF.2_S21sTavzWW3TuEAgpn4R.jpihnwzYGyMhmFZNooj4B
 ol4d5zEZ2we2nIKndWHCbFnzqFdzOsRwBNRvFwMSj0jGMHokYQxq7UNXeaSxYGbMffM8mmeaURrK
 V01pnu9OLKoQ8VwZVf8RS4lf5xpR2H24Pr3Yq1_pKgJiUv5b5wbSJtpT9D7pNY52o1KlcX0DTjsK
 m0LPfUqLH._4_IADLnsPe2xUFbUZAIjVLHmF1tHuv9ypJRFMPfdsFIh4JBGWljbHaUPGos.43LJS
 4Y_1YEke9D3.Iae4U0M5qkNBBEXZLAMVW0tn6xd9IbeTKuKqnTBzmtc9rS._8D0R0s4UOd_4fK_Y
 G69bwPVcN6KlLh13vMfpPrqPeczsU3BmB6sapTxtoGSAXvARlhtyBglfZm_L0rlGYivGyjol3xap
 DDQwujURvh.31
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Tue, 27 Oct 2020 12:34:21 +0000
Date:   Tue, 27 Oct 2020 12:34:16 +0000 (UTC)
From:   "Mrs. Caroline Manon" <mrscarolinemanon01@gmail.com>
Reply-To: mrscarolinemanon02@gmail.com
Message-ID: <1636342518.2807251.1603802056790@mail.yahoo.com>
Subject: Greetings from Mrs. Caroline Manon.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1636342518.2807251.1603802056790.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Greetings from Mrs. Caroline Manon.

Dearest,

I assume that this message will reach you in good health. Though I did not =
know you in person or have I seen you before, but due to the reliable revel=
ation, I decided to share this lucrative opportunity with you, so kindly co=
nsider this message as vital, believing that you will never regret anything=
 at the end.

First and foremost, I have to introduce myself to you, I am Mrs. Caroline M=
anon. the wife of late Mr. Micheal Manon. Director of High River Gold Mines=
 Ltd Burkina Faso West Africa. Presently I am suffering from breast cancer =
and from all indications; I understand that I am not going to survive this =
sickness.

Therefore i have decided to donate the sum of Twenty Five Million Two Hundr=
ed Thousand United State Dollars ($25,200,000.00) to Charity Organizations =
or to support the Orphans, Motherless Babies, Less privileged and free Medi=
cal & Medicine for Poor People around the World since I don't have any chil=
d and do not want the bank to take over my fund. So I want you to handle th=
is project accordingly, accomplish my heart's desire and utilize this fund,=
 I assure you honesty and reliability to champion this business opportunity=
.

If you are ready to handle this transaction, =C2=A0i will guide you on how =
you will apply for the claim, so that the fund will be release into your ow=
n account and you will take 30% from the fund and the rest 70% =C2=A0will u=
se to Charity Organizations, Further information will be given to you as so=
on as I receive your reply.

Remain blessed in the name of the Lord.

Regards
Mrs. Caroline Manon.
