Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1817E2327C3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 00:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgG2W7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 18:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgG2W7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 18:59:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BFFC061794;
        Wed, 29 Jul 2020 15:59:41 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o13so15369584pgf.0;
        Wed, 29 Jul 2020 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=IM1b8yUl/RyYaMsIDI5tr/fFnyyMh2e4jCTTItXJtug=;
        b=A+IZUxsz/tr708s+cQD7u76yfXI9tVJyOIZyWOv/S9Gpxwkp6PpjNlPteDJWGgEYxG
         /XlZeth3wKFGJb2BGVF0+J9gQzlkPZA1bI1ICjPtBFTlyePlAbGu/Kh9wdaDWdjK8rDJ
         dfBI8SoRsKybFiB+1xJNxpu3iggm0+JADxeuRM8K/gmQvZXJXXFMNpz3eCFhtpAiTmOh
         b9Ccc6JgRk6NSzbSosvxKRP+zoqHqPDZNTfyiRPyOg+5ppWd6+WcIkQXzUHfNNtgciKZ
         OvlkthmK2kWn4qeaoPLBfqd1Vv8llCjc55Fr+Yk65x3vPE9Xg0xjv/iD/0fSo2p6jw4U
         C6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=IM1b8yUl/RyYaMsIDI5tr/fFnyyMh2e4jCTTItXJtug=;
        b=cG5sJFJZi+YwsWQ7l0t+pNfwWP2+q3G7KABixbVcZhamGjNoQehYS+Zqq94mtFCHO5
         TaHhP+S2YefMpMH8KCY4dBa8IDonOQ9b9YmD9N+dCj+4EC97eE6wJkTgIygBS/dS+liF
         mOIBA9LO+G8eKMMKb8WFFI5Hl6/bz3lhXzRHvgUFIbw8hbvr6DIRoD62Y3TYvL/R443m
         D1WSHPOnE0dAP3KzN8pHhzngNGR1AGUPP8fmVCcbLtzpojtyJUuPjyKYnJ1VVJ70Cwb1
         J1f2MO4H82z6LxtVR8TejLsSHvHuwEPgKaQCZUc3XCYQUwWRI6lsvXGKpdKnHVWHVlQo
         I+WA==
X-Gm-Message-State: AOAM532WhpcM4oehtGHiPMb+7WV4W3BX2IVaMyLpijqn6hintDQqzcFo
        +SQ/DC/gr7+ojOy9P4DxiP3OFBvPYOM=
X-Google-Smtp-Source: ABdhPJwEU4zxHtuBlNAAsDhttJXr8dobV6va11FKRwYyCbstWJZoVfAg/x5Iee8gKWbGg7Q1XxHLsQ==
X-Received: by 2002:aa7:9ac2:: with SMTP id x2mr292734pfp.57.1596063580650;
        Wed, 29 Jul 2020 15:59:40 -0700 (PDT)
Received: from [192.168.1.173] ([76.14.31.91])
        by smtp.gmail.com with ESMTPSA id 76sm3598226pfu.139.2020.07.29.15.59.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 15:59:39 -0700 (PDT)
From:   Mark D Rustad <mrustad@gmail.com>
Message-Id: <3DCA0A88-0890-49EE-8644-E6311E891C55@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_7DE39EFC-2EDC-4C73-8668-B39BBF04D3AF";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH V4 2/3] mfd: Intel Platform Monitoring Technology support
Date:   Wed, 29 Jul 2020 15:59:37 -0700
In-Reply-To: <20200728075859.GH1850026@dell>
Cc:     "David E. Box" <david.e.box@linux.intel.com>, dvhart@infradead.org,
        andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
References: <20200714062323.19990-1-david.e.box@linux.intel.com>
 <20200717190620.29821-3-david.e.box@linux.intel.com>
 <20200728075859.GH1850026@dell>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Apple-Mail=_7DE39EFC-2EDC-4C73-8668-B39BBF04D3AF
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed

at 12:58 AM, Lee Jones <lee.jones@linaro.org> wrote:

> If you do:
>
> 	do {
> 		int pos;
>
> 		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
> 		if (!pos)
> 			break;
>
> Then you can invoke pci_find_next_ext_capability() once, no?

Part of your suggestion here won't work, because pos needs to be  
initialized to 0 the first time. As such it needs to be declared and  
initialized outside the loop. Other than that it may be ok.

--
Mark Rustad, MRustad@gmail.com


--Apple-Mail=_7DE39EFC-2EDC-4C73-8668-B39BBF04D3AF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAl8h/1kACgkQPA7/547j
7m5rPg/+PLg09fE2ihUlYc2tfxKI2OFvTYSVtj9/VzXoB+mGfkYbu6pvuo7TQxFJ
EiKXeHRVk8X0b5fRitc+bfOh6Pnv5UomQBGlJ913QE9Z7ihTXIgqgehYGE2rUgXI
c32yapNDuH5O+HcM1o2er+iBPkAZVTLvEbIss82F32QLFsDtouy0ZtlYL3hNE/9B
eNW9PFKKoJ04uJwL31jM51jv/pZESGxaZljUDFEOmScsTg28KyBe1DwrXKFEUwyF
ItlBTaY1AZ7rPktbJZUEuRXpjG5ryCfk+m3GU6CDwW/+bFTYNEJaEKA2IN6PqeHY
FUltSWLSktecZqE49VTmlpfFiw+iTCOc7LnhzaV5S6HZRv8e3YGf/emqtsFs3NWY
TkEAdOkNBpp+LF06Z0kkqHQfLiVG9sFv7WecHxYzJg5R9g3NM3e6H5B2B5gDre7V
2Z5K0aJj+XfPAkyUR0qF5rJDkhjHM9BsPsEZecX7Bi8mh70eLFhI0FjCnEqrqlEc
T9muHDC4bILxgm+42CJ+LuAyARt9q1v41hu47JuqLJEw1IetTaj8CptwRfMt1d6a
jHmST0dxpYqjnHIZJetE3GmZeRe0UCb3J0OY+aXb0b9yNiBl8lC4XhiFQxQ1xKzJ
LMVCGyobQ2oISbAW17Y0BtyN/C3XvK505BqXGrcM5RXrG//1zeo=
=hBk9
-----END PGP SIGNATURE-----

--Apple-Mail=_7DE39EFC-2EDC-4C73-8668-B39BBF04D3AF--
