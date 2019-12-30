Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD9D12CE40
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 10:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfL3Jem (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 04:34:42 -0500
Received: from sonic314-15.consmr.mail.bf2.yahoo.com ([74.6.132.125]:34080
        "EHLO sonic314-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727243AbfL3Jel (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Dec 2019 04:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577698480; bh=YooljpITC31Cc9KXMfJzAPmr/1tCBEdX27fhfqn54Fs=; h=Date:From:Reply-To:Subject:References:From:Subject; b=bJ8zajuKko9Qp7lnufJkDY+wNt2FXRIRvA1Bp3gAVb7B2BO8gOkh0Yjz0vRiGswJVP3OJBhWWA5ujA4Gc+sLV+LirPxhT0hTcuhXGXZCiTT/uY8xfNI+H1qVb3d8tv31hre5OKnt+IofFXhry3CV15nhcjBsQnFymDW83bokZmhbjjEUzYM7Ogpm3sTJVFsC5an8kqrDdtT0csk4rFAB5AWgsvbUrcj8fvRMPGqy+2rGPBRj94PjsZK1eoyVshbWmNe9ercX2JMlijosJPczAkuaVR54ZsEApmNU3XACvfdsZ3mDNkDvBfnfh4QgfZLF1PQfWkCK4326OKn49e6luw==
X-YMail-OSG: eEzk7jgVM1m72GeAJkvjLjnl6YuZdIcRZJgidG6pq0QpUBPtGqb0aPSNBvnB1vA
 WqN_tB_nGQs1XHkLHIhP5KKGS2nFHx8tBdIio1J.3mNXgB.lGEX7XfMW_UVBbEJG5BjCbxV6iXcY
 RHcM49XyHrTmo1ZLabBb_ZAjnab8DmxsdaCT2L5V8ud7Wthodyyo61Wnk3SZZ2oujGnYxbGUXIUp
 f7NNJInV_fCV3OEKFMJkgwoc86SIu5n31No.Spm1WozON8ldgMQmOMfCWGk_p__l979kPWtcin7m
 hcuMCeepDroxeh13r_3prsBkg2n5ATBK3oJPsD6sWxJNMMHT_VXdxTsX_TY892kf1Pn.3UC8aELS
 Prjr4ylyeiixVF68UvS.vqbkeKoF0LQcS9FbLhm8e0zlsnGeCUfh1Uikagpgo9AGxPvBJCGDrwXT
 CkGneTBRH0qfp10JjR4vb6TODwWNHIpY.Zo16TJDY7U35ejyCmQHTR2WMREGVSINMB52HRmtcSU0
 M_MCoK_RkHPwfYF1Hbxw._W3yvbY5GS1hhhGBVoRW9qIM0UfZz2r8a2ug4uEbNBW.ecAr6r4YjyC
 mwUrgcEr7E376GQ2ekJ2YfEquwSeVxba1B_M5E7N8bRytk0gPhYAv_aeDHQLg1hcuGZ1CiJ.L5eR
 Z1iLWPvweMOLtL4iTepI5HWyqeKLiN7P2DTB.utPVAEOh3..cd8y.Y7ZlyNOsVEZ7pTTfKmOVhcv
 u5l0yVYFEs..MQ1q8gyk_pn8BIUA.FiarjQ.H9Uf8HxlgERks2SUnIfEm7NHNsCs9.suAKgDHld6
 Dtxa.hsDx4Pb9NQKWQvSt0w42re.se73nLhHv0hPITfkZqtuLobnxC23eLzOTo9WtYZB2nfiq8E.
 smbKn2UuDN5p3z_XjjVv3fReu6s862g.c6CBMaT52frBt4x2xWjvOWVYjg1lQk9OEf6CGnfZqNz_
 vqmGhziDvYTdGuqG6KKy4nB1vJApJNSsOr7KgBzesESh5zj4ZZiS0wFebP98xfaxlmcUvot_tvUq
 2Z9Y9Ur4mHJPA9thEjGwTKNEQRm_cJgEABiAc1DD2_lJVw6x0h1QJe8BAARMbqQLo5Cnz69CQKs_
 HTjgD5emejOyOv8Idj8R6P4WxtrpeRL3bmv3QEeJ6KkMwDr3u3crQG8uoWsaiaBtesCFVGEmgDCk
 vaZxgM4snE9mzNDAGjRY5jWsbvZHVc_gEPhrsN8DKbKq19cs8Fcfs4yfhPH31taCOS0qauGA_gxK
 lMZfjkXkJbq6WEchvy3FOcfkhY205oGSEDgE9v7xRCIWYvx8cGHxKyLIPcYvFlEZ.9An7oMBh
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Mon, 30 Dec 2019 09:34:40 +0000
Date:   Mon, 30 Dec 2019 09:34:38 +0000 (UTC)
From:   Lisa Williams <ah77900432@gmail.com>
Reply-To: lisawilliams003@yahoo.com
Message-ID: <1054553309.3099532.1577698478836@mail.yahoo.com>
Subject: Hello
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1054553309.3099532.1577698478836.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Hi Dear,

I was just going through the Internet search when I found your email address, I want to make a new and special friend, so I decided to contact you to see how we can make it work out if we can. Please I wish you will have the desire with me so that we can get to know each other better and see what happens in future.

My name is Lisa Williams, I am an American, but presently I live in the UK, I will be glad to see your reply for us to know each other better to exchange pictures and details about us

Yours
Lisa
