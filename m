Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556F6286414
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgJGQao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 12:30:44 -0400
Received: from sonic313-13.consmr.mail.bf2.yahoo.com ([74.6.133.123]:41782
        "EHLO sonic313-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728051AbgJGQan (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 12:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602088239; bh=PxMwWzXvs+dqOoH0/FHvFmQpYH2JguaCUHYAVLLmaiw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Igv8GDmah7CHM2MKpNRZpQkxPE0/cHPOC5RhBukZNP97xAR5d449RV4Hv+lAfa86AC/M7cKJUUB2pdSzwEaz4oE7mv55HRaXLEdqSWhkxG3Byj6uwHGspSSNW7pzmplYPCqD/4ajk13uqNbTARF/+VBlow96vrw7uwNjW+QzEJGsiHgTBXc3/jwPzc94VHA+b2UQj6Ne7zVJ0sdXnKZiUpfpnCKi+n3pgwDyU6yYCBZzypH+wh0SPh3oKtdINpR6tHwmR9X5GrkHJ2rQ/VDixy73+U0gYUV3VUe9yDe6dExqoZ0Xc5Y7Q7EGw0rdtdjuG/HMywxILQAj4UWN2aL19A==
X-YMail-OSG: m7.UIRAVM1k9IHpsSF_9aOSrQGJM2c4H6eM3UVt7KHA9_uvFmf8kxv63vpI5KFK
 oqpQz4emE_LEUvajcmQvgNurTCqVEb9z__yfjJhX.2gkFZ9Rr0CGqIUSM5Rw3.91b7mAjg3ukNYy
 epxkbDeWCdDVkIFU3pooljRZHDXumcdKwrfoq3TZBZhHmRay1mzV9dTilii0QPx1rkvAhdBoqYUl
 SehPFlTG.isQQziUHz.pAF6yfK5pF7Uh1Dvfi6tYh9z9JToUjQ6i2addZxo71RL.Ssmv762zveim
 5NcN1RttpvH53m7dDm9OofCKTgrFS0dCVgjtw8WhoPX1m_XUdZIvl_Gcd2Cizw5UocYDoqUzuWB7
 5V7dTn9Tdb.3RudtT7NbKceKrc8N_1Jwauesoz6ox7z8SV1WGQAu_adgu5a1VoT3OOVLAVofrsJ0
 ywMoMVA4hFF2NwCHHxl21bXUChzFfdLvTf5IlRYunem1M8jBCPuQelIGZBBqXiubBsdQL0J2.2xz
 5cMkOWU_QJ_cGYVzaVGQrsjRNgshYgvaoPj0GNofARp_20UXZt4BKbXHuuzAdhb.Z68kHWpcZ8wE
 P3dM1cIVFw5pnxLkMlZOI5JlEokhn2mw31DRru_vRFNiKvlfSEwcNLhFrvGyiEadq7iLcbCrW1Zu
 Hy21m_X88ZZr3ub52OXe_RlA5GYP4owS.lMAtuRq737JtpEl.Dn6HsONlDd_yfsvTfKyolrCyiqu
 egeaDGYMzW45sKiwJwNPsv2t9MMt5y83pAof3nLNMpovkUIXO1LkYIjFyXg47RzLoHYouR7315Qq
 Xa7dMdQgeneTSUJXaa4jnUZWrBTlz8o9ce4UcatJOq.JSFGdmQdwLmcYsgiogUK3xr1Rzn05.v5n
 z.pjGwpN5hTQkseHe3l71ljxtQyRQpeTJhcgnEHDJaChiZ.RrQCy6uC_ResaiTSdfTbrMGxVjo7I
 ciAQ4aQWHFzcbbSBAqDkm_7Bb9r3Cfmwnwyv8C9M.CER7r.dudz0VQP0mlXF52iLVEDKEYnC0G9o
 txVVtQX4nP7gXL.ehF1Z_E3xVpyIhFRv9.dSVzOjPXcRrBvjE6BK.u2Td4gfz8j.nT9g6o06HSMg
 rs_BVzOdU9cn5QqWcXG7fOf0YDe.nAX9ELK1RQgj7YXqDJPzhmXwVQiOXDKwv_wmrMpm_6z03BwZ
 cBjpLsNhGeq7DQ0MYneJi_JRjEgvo_cfG5dyRH6vHQQMSyfNDSzbYHZ9pKM4xLXYMCt6hLZc7KNV
 MLR_jZ2MTttfkX9eMEk6zmBQESLqdCe764s54wcWa8KJ54wS3_PgHkQHuQ0j79Up6qpEaqd0PFDs
 Mh09gB9wox6T_xTVJAIOq5GMiQePep_KuniV5n3OYkogucvacxszVNY8jFiUVFyXg9bcMzv5XNRx
 ioAas8T0CausajOUReODHctMqqj0c8aNZWVMGWw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Oct 2020 16:30:36 +0000
Date:   Wed, 7 Oct 2020 16:29:34 +0000 (UTC)
From:   Marilyn Robert <fredodinga22@gmail.com>
Reply-To: marilyobert@gmail.com
Message-ID: <1390213149.148810.1602088174847@mail.yahoo.com>
Subject: =?UTF-8?B?0J3QsNGY0LzQuNC70LAg0LrQsNGYINCz0L7RgdC/0L7QtNCw0YDQvtGC?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
References: <1390213149.148810.1602088174847.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16795 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCtCd0LDRmNC80LjQu9CwINC60LDRmCDQs9C+0YHQv9C+0LTQsNGA0L7Rgg0KDQrQiNCw0YEg
0YHRg9C8IDY4LdCz0L7QtNC40YjQvdCwINC20LXQvdCwLCDQutC+0ZjQsCDRgdGC0YDQsNC00LAg
0L7QtCDQv9GA0L7QtNC+0LvQttC10L0g0LrQsNGA0YbQuNC90L7QvCDQvdCwINC00L7RmNC60LAs
INC+0LQg0YHQuNGC0LUg0LzQtdC00LjRhtC40L3RgdC60Lgg0LjQvdC00LjQutCw0YbQuNC4LCDQ
vNC+0ZjQsNGC0LAg0YHQvtGB0YLQvtGY0LHQsCDQvdCw0LLQuNGB0YLQuNC90LAg0YHQtSDQstC7
0L7RiNC4INC4INC+0YfQuNCz0LvQtdC00L3QviDQtSDQtNC10LrQsCDQvNC+0LbQtdCx0Lgg0L3Q
tdC80LAg0LTQsCDQttC40LLQtdCw0Lwg0L/QvtCy0LXRnNC1INC+0LQg0YjQtdGB0YIg0LzQtdGB
0LXRhtC4INC60LDQutC+INGA0LXQt9GD0LvRgtCw0YIg0L3QsCDQsdGA0LfQuNC+0YIg0YDQsNGB
0YIg0Lgg0LHQvtC70LrQsNGC0LAg0YjRgtC+INGB0LUg0ZjQsNCy0YPQstCwINC60LDRmCDQvdC1
0LAuINCc0L7RmNC+0YIg0YHQvtC/0YDRg9CzINC/0L7Rh9C40L3QsCDQvdC10LrQvtC70LrRgyDQ
s9C+0LTQuNC90Lgg0L3QsNC90LDQt9Cw0LQg0Lgg0L3QsNGI0LjRgtC1INC00L7Qu9Cz0Lgg0LPQ
vtC00LjQvdC4INCx0YDQsNC6INC90LUg0LHQtdCwINCx0LvQsNCz0L7RgdC70L7QstC10L3QuCDR
gdC+INC90LjRgtGDINC10LTQvdC+INC00LXRgtC1LCDQv9C+INC90LXQs9C+0LLQsNGC0LAg0YHQ
vNGA0YIg0LPQviDQvdCw0YHQu9C10LTQuNCyINGG0LXQu9C+0YLQviDQvdC10LPQvtCy0L4g0LHQ
vtCz0LDRgtGB0YLQstC+Lg0KDQrQlNC+0LDRk9Cw0Lwg0LrQsNGYINCy0LDRgSDQvtGC0LrQsNC6
0L4g0YHQtSDQv9C+0LzQvtC70LjQsiDQt9CwINGC0L7QsCwg0L/QvtC00LPQvtGC0LLQtdC9INGB
0YPQvCDQtNCwINC00L7QvdC40YDQsNC8INGB0YPQvNCwINC+0LQgMiwgMzAwLCAwMDAg0LXQstGA
0LAg0LfQsCDQv9C+0LzQvtGIINC90LAg0YHQuNGA0L7QvNCw0YjQvdC40YLQtSwg0YHQuNGA0L7Q
vNCw0YjQvdC40YLQtSDQuCDQv9C+0LzQsNC70LrRgyDQv9GA0LjQstC40LvQtdCz0LjRgNCw0L3Q
uNGC0LUg0LzQtdGT0YMg0LLQsNGI0LjRgtC1INGB0L7QsdGA0LDQvdC40ZjQsCAvINC+0L/RiNGC
0LXRgdGC0LLQvi4g0JfQsNCx0LXQu9C10LbQtdGC0LUg0LTQtdC60LAg0L7QstC+0Zgg0YTQvtC9
0LQg0LUg0LTQtdC/0L7QvdC40YDQsNC9INCy0L4g0LHQsNC90LrQsCDQutCw0LTQtSDRiNGC0L4g
0YDQsNCx0L7RgtC10YjQtSDQvNC+0ZjQvtGCINGB0L7Qv9GA0YPQsy4gQXBwcmVjaWF0ZdC1INGG
0LXQvdCw0Lwg0LDQutC+INC+0LHRgNC90LXRgtC1INCy0L3QuNC80LDQvdC40LUg0L3QsCDQvNC+
0LXRgtC+INCx0LDRgNCw0ZrQtSDQt9CwINC/0YDQvtC/0LDQs9C40YDQsNGa0LUg0L3QsCDQvNCw
0YHQsNC20LDRgtCwINC90LAg0LrRgNCw0LvRgdGC0LLQvtGC0L4sINGc0LUg0LLQuCDQtNCw0LTQ
sNC8INC/0L7QstC10ZzQtSDQtNC10YLQsNC70Lgg0LfQsCDRgtC+0LAg0LrQsNC60L4g0LTQsCDQ
v9C+0YHRgtCw0L/QuNGC0LUuDQoNCtCR0LvQsNCz0L7QtNCw0YDQsNC8DQrQky3Rk9CwINCc0LXR
gNC40LvQuNC9INCg0L7QsdC10YDRgg==
