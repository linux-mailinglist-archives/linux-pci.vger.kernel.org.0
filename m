Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC738273271
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 21:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgIUTGa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 15:06:30 -0400
Received: from sonic303-3.consmr.mail.bf2.yahoo.com ([74.6.131.42]:38108 "EHLO
        sonic303-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727681AbgIUTGa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 15:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600715189; bh=WUESKagEm1rdmKBSWVtDCW1cpdCKHA0ui3YTmWJbjYQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=DNtm5GHMJdVgZ/PeoMoakFubxeWj3C3P3WlRa2Va46CYf+oHuT7DM+okYZOUsi61Ce4pbNJA78kS4JBLj0XVQlwm/LvaZrA2heuw7z9GnKSyAAclh8cLY+zN6KB8QWbG/kkV2yxDNwtnm49PqDyE+T68NOdL61y6Do1O9pERiHv2xZTVi/FUhsPWArBvh3+O8RfeOgxM6t47u9cnICcfFN+R3J/dk+XEiPcypdUl5PMA0m4BWkXQ26xZAdUCuZ1QdzlcgPBgwEjPlQmStfsTovUDUcLr5tnNxJHSaNi1dSXcq4YqJCUXOI4aE1ZPQJADmjmQh/xtRfwQQUIJJ2feZA==
X-YMail-OSG: iwaZEBYVM1laMv6DvjiBqoCzpDVJF4CjzpVnwMO1h8a60GBAzl8n6aIctwFLwmO
 fTULge2gDCkhhQF1G9f47rwnemyygk22EeMSDgFVGOjTLHsmCV15oNlsqNMfhmUwxecuGptXA99P
 jFtyc1oa7Pr2foAWaWTdct3KH95ibVvNG.YvqhdF5s2YSVf2hP8v9kzc2UVsrxvjWqd8nb7C3DBU
 HO1QC3crBKmwogcKzBJQzDynRM9aAP3NnYqv4l4XRoMkDV_tPdE6sJYpP7CKOdaHEshDvkCuv0et
 bAYmN6CqTTAqPHPt7TK3vSm47BZSnRIj9UNNaeVo5ZytY.JAGAiQEJJOGxLywKFwUhwAwpdpEVgT
 PFd0xlqtlYIFks4Ag_DD77V3dwCwpnJ9_hahcT3K3ckGFwIGbuPkbGPNq.rGkmOe95QaN2KDHet0
 JW9XKkrageeFK.5ogpXrsxqdb4OOvCvusMq7Vxdboz2H09r_HydNSyx72nI_tvTRXy5RwP8jW4eF
 As3V7xffmg61WBa2TLhRFA37quqDiQT72j4z_oKKvQndMDVVi_lCHwaGSomkJSMfoBrJIPvtuZmz
 VOTS7TYYtQfH0WIjpsPl05D6uJhDyzUAAV6MJNZ31qe.nqeUlWfFLhtuNJ_XgPzFNla6eCwtupQI
 z0Uy74rT_koVlhE1aJLVvkqB2T8B_KS0pPPEhm1wxkKgiV2_7_6vGevhA7EoheQHRb2FJZnWm9Ow
 I7CTSH3W77EGn5J0zRBQdABwa3geLjgUvK6dIm0Z4PSquHz1S9LQt09J7A6fZFK4QgjFJN1.pV96
 0A_ROnqaXdn3Ju5zJQ0RQnVJd1_uUg_s_TxJDO1msXDQueUWUy8OrJJ72o9tDTQQMV3a3ZelAIzm
 GRLR0Gf72njYNtliHaTHYIAel.bif2OyafnV_O4qLGDeSVajGqTk5W7u3Se8TxMEQiZ3fHRkVERq
 KWRi7LMOQB876_RHmdjJwxdP2vMaJ.sRh_NwqtCx4cugppp2JEypU2wLIAKJVmBtQrKa7X_cDoEw
 _rcMGxG7ky_J4OL4ZtPmcli7JpsVe7WAbK.FsJOTmaWsICn409v_T.XXrFDqhxXEli_k0Ef.Uc1v
 hY829bGJyq15oHTx.P1f9OCusXhkGGqDvuUal35o9mogyPGPeFyScEIJ.JmxHe9cKQtE8JvHp0vv
 FwNwo_6u30Vg94VvYDhaiQRBiewApTsd7CLd3N4c801ZxbWRhH8b1bbl5L_N.JQZwX33dUz6mzQQ
 aZFCqI6ydOcI.7DMqvOQnsEgdztI5B.sF3OQ_lhrkYfwK.Fem6gQ9icNmjrMshwgzF7dxFcdC794
 zw_moRHQraMoDDSlrr1W.MMIRvs2oWgHBFAFRfXkTxelbzan74s2xwdzoNqXoiglp1zpYVrzahGB
 uQtWjljFH8k5a3p47GQVAJs4J4XRYQWBKq6SLtimnuBvJbSjDNFKzetJVE3pD
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Mon, 21 Sep 2020 19:06:29 +0000
Date:   Mon, 21 Sep 2020 19:06:25 +0000 (UTC)
From:   Aisha Al-Qaddafi <gaddafiayesha532@gmail.com>
Reply-To: gaddafiayesha532@gmail.com
Message-ID: <803192571.4469086.1600715185685@mail.yahoo.com>
Subject: Dear I Need An Investment Partner
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <803192571.4469086.1600715185685.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear I Need An Investment Partner

Assalamu Alaikum Wa Rahmatullahi Wa Barakatuh

Dear Friend,

I came across your email contact prior to a private search while in need  of your assistance. I am Aisha Al-Qaddafi, the only biological Daughter of  Former President of Libya Col. Muammar Al-Qaddafi. Am a single Mother and a Widow with three Children.

I have investment funds worth Twenty Seven Million Five Hundred Thousand United State Dollar ($27.500.000.00 ) and i need a trusted investment Manager/Partner because of my current refugee status, however, I am interested in you for investment project assistance in your country, may be from there, we can build business relationship in the nearest future.

I am willing to negotiate an investment/business profit sharing ratio with you based on the future investment earning profits. If you are willing to handle this project on my behalf kindly reply urgently to enable me to provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated

Best Regards
Mrs Aisha Al-Qaddafi
