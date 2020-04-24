Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609211B6ECE
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 09:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDXHTG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 03:19:06 -0400
Received: from sonic312-22.consmr.mail.bf2.yahoo.com ([74.6.128.84]:37138 "EHLO
        sonic312-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726051AbgDXHTF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2020 03:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587712744; bh=SGvvhU2UWXzbg2f9vxSHyVOB5gxWkye3IYlpV46W7BM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=IQXBCeVTWQHMb1dQ/bxFT+LAcs1q6SqJPNm3IphYPNEv4WJtmiEhHrutfrUsrudiSPV7XaZPuKj4J8Eaitxj+vOjlCuEQKppvcEM5dx0APIn85cmgTXpf/vhPfOfWqajfdKOYjG8wdL+kRaweJOPYfRU8uN7G1HAUrXi/Vnp+89YFut5qkMXVilmtX3gDLQrdvFylH1zEbUzQnhKu6z/SmVtTkQLQZKHW+4e7wYx89+kcHeJMzAILHFcbsILUtuI4elhjmy4PJofAQsbof4sZzTl2HYjTaULBTHSQTopYRgeBWjDwOvzLvJYn6D1NWrm7DHsxbw8g5Pq6v+TitrHRg==
X-YMail-OSG: ZJAU9q0VM1lVfirKAQ.G_Aw8CfBvLygL0oFIkY9LGAoLmHatef4607cq6DSfcc8
 CZxLUXYuM2xKA9Z_WTpipDo7gAsvBNDJIEvXF7vOsxMvalDQsGuwhJJBwcAEItL5XQ2hvEoK8XBw
 8sN3x1G0UUwMOQ8Oi0aKhPxenXyCSxM_4VsccUEYsWu4R36eu_oZK.vnJ9HPIJLUgRsEYnulkMYn
 P06vSwaEK19AoDjg3BWHxQwxaykYB.SW_wHuZCcEfOiXcXM4PrrbYIacuSA3tKD20nE2a5SVe217
 8i9cR4G7JWbD47IRUJyIRzZbOlxlRqw6gOKHOxXLMYk6jeuiuMochP5_aSM28y0jtzauI8LkViSx
 7cmXk6PcEpMS_ahH0388vmFPz74K2GXA4Q3oViwX8AAOmAAPcK.SBhh54fxa8NpuoWFauwl.L5M5
 NclBedusxaTEam80A2RqivW.J9w2C7msaigMnBWpfktzq54Yrni65KRSDySj_PJ3VgeStxud_M7B
 5IQMu9d0AUcBviCgWHgc3ALVsBPtIp3poOyItsdfOgW1cBYxrS.PIZCFi4shJWBrcct0XGE42rHd
 ZMVBOXk44X7CQPMhJO2adj4.LFws98imQEjvqGdVAaEowjnYl3V5bsLM6D1.xSC8LhitlIBHYQ22
 dDJiSVxr_4I_YFWnrafnhIEm4VYAGPzDNbDS6qrhLHC1la1lXsIguaM5zWAdMrleEoQNifsmi.qr
 iXLfop7fLgBo7gw1xwA8z2VZmqg43libsjSKAL6PS4w7Z6kFy3PBmXu2S.KYUNoaFIlkQoWsIH2Q
 akCHi0HKWS_lmitnNWC1EZzwWZgqjq9XAEp9OtWgkEfCP1U9zJHqxkVNuf02wTXQaXsLnnSd_s3j
 FfmC90IiVjCbXLtqKnPed0GtlPcFcgMcUSpRYfLO7v_Ga2_zXoWUBRuj5pBDsp81FD98I_kBPsEk
 dldv57j2vrUP8WmohHedZ9BUN0jqVN8NZLmxV8dThaBeynwB39vxzFL6Zf_buXD2act21MCr0UkB
 cUFMg_2lSRIk50JOd_x22nLiP6SaEzYyzxEllIRPwpO8AirXAOnLA1j2WOSw.vxBvzJ15zHTZnK9
 DLjhq2B4lE2AX53FClI78qfvvAiAMyn3Y2v35UrS2dIaAfAvkBALXnauC58SfDEJ3qv2AgbFrlvI
 SJ5w5Ng7l7JLqWonPXjoiQOu3VX7MXsTmwd7pYGs1y8i.Rq2eVERGeVBVBUmac_zg81scfatAKxa
 UKI1NKINxytcVZIxeA7iGKiAr1gNxOK2qNvqNXYeyA0ndE88BzVoaXbz__EM1OZgntaxe
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 Apr 2020 07:19:04 +0000
Date:   Fri, 24 Apr 2020 07:18:58 +0000 (UTC)
From:   Mrs Aisha Al-Qaddafi <ah6149133@gmail.com>
Reply-To: aishaqaddafi01@gmail.com
Message-ID: <1327483723.40306.1587712738769@mail.yahoo.com>
Subject: Dear I Need An Investment Partner
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1327483723.40306.1587712738769.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15776 YMailNodin Mozilla/5.0 (Windows NT 6.1; ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Assalamu Alaikum Wa Rahmatullahi Wa Barakatuh

Dear Friend,

I came across your e-mail contact prior a private search while in need of your assistance. I am Aisha Al-Qaddafi, the only biological Daughter of Former President of Libya Col. Muammar Al-Qaddafi. Am a single Mother and a Widow with three Children.

I have investment funds worth Twenty Seven Million Five Hundred Thousand United State Dollar ($27.500.000.00 ) and i need a trusted investment Manager/Partner because of my current refugee status, however, I am interested in you for investment project assistance in your country, may be from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated

Best Regards
Mrs Aisha Al-Qaddafi
