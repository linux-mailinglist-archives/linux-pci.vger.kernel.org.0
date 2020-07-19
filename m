Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13064225109
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jul 2020 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgGSKFB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Jul 2020 06:05:01 -0400
Received: from sonic314-13.consmr.mail.bf2.yahoo.com ([74.6.132.123]:39298
        "EHLO sonic314-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbgGSKFA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jul 2020 06:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595153099; bh=qXBWf2EoWT9gmJgm/3NiogFnv3V/rxlq5ApKE+Dow4k=; h=Date:From:Reply-To:Subject:References:From:Subject; b=K/YcAjYk4TvQWaBwnMLFJcDqfvvcXv59nP2+IWEntIwmoRgRsNO05gCxGp2/nbbTXQR6jROAL75Tq5qivY9fixjfkBJQ0mA/paykAHzEz/pBnAhLctBdRl45sHJIdU8Ec2YlSgd5/s0Wjp3Pv0Ohjq92JImdnIVTc4RbGlaj0In2PQOBgp52faRBTCePGlh26rWsnAoaKmUGTOSI267MyNO9P8QiVVBkQUi6nVeUXRciu0XS6QLqP1h0s4R+/5KQ3bDSBCFWlasB/m1qWH4wvZuuP27d6FZ4r4FAL5pS8pNnsLbjDsvWJfDAJpQ9khYVDu3x+mVbqfTUvLSM44tdrw==
X-YMail-OSG: vx0zszsVM1kxDqbotIPx00qKNUpRdDbVKPw829FURANzMC5wJ2Q.hCx9.sAsMH7
 ndt_U_oUrZpLJgOgOqb6zWHGyqBQ2Podqr0IZS8ieTq5Afodz_xGTy1n1IvY9Q5h6tMO9mgHQzXm
 ZKcoDux8V429JyaJgqBiVT7oeWVwYowd1rFb7IxWoDAZY5fbTUIC.6avrH9Hiy1CN7fCYPwnuFJX
 tpYVEnQCYAfAvBNhhfoCAwHgF4joz6IXEwmAB4Pwdf0FzWJBsndWqoLW9WwxrNg2e1ymQ3c9BFwk
 kjCR89dXTt_M18sqT7psAdbi.NQU4N7jIsnesNtyLSerIHxwC32jLupCOZ8kDWQBXuSbBPuJcFXE
 1qXyX3shjKCYP6w.1sy.YtXVFmwIgq7iPwKkV96ukIpxr.vvTgsp1VRhDT4mPhAXS.zsQkYUXg7q
 3u3SXEftVmsgiFm63j0gm_tBSVddwOVqQwfy2hXLgo0R2vSgUZg0BfYr_WerHujq4NeUAqPhQSSf
 3O..9RnaXYCyaD5A8TQluqnSwvg3Yc5mRU3_Wc3i2.PFe3OcxGaiZySIhDp.esbSrr6fFnmgdWRE
 .ekHQCsywXOtOGHtxlHl1aFZDyPqHlkwD6C54zwOs.0Bf4uJEkhbhkyR5zAR0q9aH8x68y2ArAdS
 k9N.tBbA7mUw1wlnydG_q2732hCggZd61WskD3gxsgIDrWqlG3jzD5p3_kYIx.h7Ca1EqzCd7KrX
 ryBDHySKhU_KesH0W8DQ.2.SqLlGTwiis51qLbiT2OugjnUxa.tgsKL9bRbZDIlaBWSvUuQRB2Mw
 gA78HAyQx2kg3pXtFXtusayjTjz5gCkuS5ie.VX8g7TZ1mtIFkGM7Xeq8S.HhKtQ7xg1duT_pUB2
 rxq3XtMWCrZhWGImqMRZfLNylVyMekDtmSi4U8GiTnAJjE1t0HEd0Y3f47jwRS25DsOgKjijIbl4
 6qLaMpLWLZ3lTIpPgUgm7CXCAKliauKy6N6BDoMNlF8vmIcwK4jlMXZ7RAIEf3hQMF8_9IuMj.Og
 5rFaDiKFBRHGXGv1jgf9kjw761efEX59Pyy0uV8sYzmr8x_d49OVlXQ_SaobFmcRfedH17inpuLk
 QrkoubvyL7W23zgPQIl6jG1t3L6Lu1mj0ww5CYk4TCYm2oiRxoi6oPqLTAHmACU3H_60e5UQ6_0n
 X5358RL3vFIWv5oUMrmRthDt3u4RDRtcMxqsX7_jd6cBWx.pbpjSWqMM7Z812sJKqE8gDEoDaQU7
 0d8zEpsSzXIPPW.5kPPSAzba_ixdCPI2kC9yQavVd_7llPLpkJ13I0BtKGOGHWqUx4qc9BnkVDA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Sun, 19 Jul 2020 10:04:59 +0000
Date:   Sun, 19 Jul 2020 10:04:55 +0000 (UTC)
From:   Monica Render <prender1226@gmx.com>
Reply-To: mrender377@gmail.com
Message-ID: <1955651903.2694416.1595153095326@mail.yahoo.com>
Subject: Nice to meet you!
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1955651903.2694416.1595153095326.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:77.0) Gecko/20100101 Firefox/77.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please do you speak english?
