Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372CE606E7F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 05:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJUDsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 23:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUDsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 23:48:06 -0400
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7281BC14C;
        Thu, 20 Oct 2022 20:48:02 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w1.tutanota.de (Postfix) with ESMTP id 6C7AEFBF760;
        Fri, 21 Oct 2022 03:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666324079;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=/8aYxY//03zrC8+CGzZm9Ti6oOcvgJCOD+2JL07i4Yw=;
        b=YBuZwHIaBFyd2/SZltFVrUSAKyASJ7yvFadjqOutZy0pgFp4KOBeQLHyfPPt0bdl
        jfxDO6q9b3a/r6ZpEkxAltdwUxFV/3ztOcUY15axFsOFrMcjceWQnvK00oShM10XAms
        0WH3f9WPwIjXaMW3SgUf4z0Ghe83Q/yjZClbXoy8FfJa+yCn/qDk40qBLJ41Sltot/t
        D7IK8qpoKbOF/Uh7xf2D9iKY9D3dYl9QIiWbWVgyM2WngKKMA7TnPeHotzupB/aXLOQ
        2Pt9xH3OZ2LY3uQzbBDZ7T/8YCH0pxaLoQmX7nBAhbFECBfcO7y7wdd8b8ialZvInd4
        iUmQKFJRLA==
Date:   Fri, 21 Oct 2022 05:47:59 +0200 (CEST)
From:   Richard Rogalski <rrogalski@tutanota.com>
To:     helgaas@kernel.org
Cc:     alexander.deucher@amd.com, davem@davemloft.net, lijo.lazar@amd.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        rrogalski@tutanota.com, sparclinux@vger.kernel.org
Message-ID: <NEsdtVI--3-9@tutanota.com>
Subject: Re: SPARC64: getting "no compatible bridge window" errors :/
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, very very sorry about the late reply. Life has been hectic. Also, no=
t sure if this is how I reply to one of these, sorry if I screwed it up :)

> This is great, thanks a lot for your report!=C2=A0 Is this a regression?

Believe it or not, I am a brand new SPARC user :). So I can't say right now=
. Should I try a few old kernel releases to check?

> Any chance you could collect a dmesg log with "ofpci_debug=3D1"?

https://gitlab.freedesktop.org/drm/amd/uploads/0ed3c92921d7f88b06654b5f46e9=
756d/dmesg

> Do the devices we complain about (NICs and storage HBAs 09:00.0,=20
> 09:00.1, 0d:00.0, 0d:00.1, 0e:00.0, 0f:00.0, 0001:03:00.0,=20
> 0001:03:00.1, 0001:0:00.0, 0001:0a:00.1) work?

Well, I don't have any fiber optic equipment: these just came with the serv=
er. Also it has wayy too many NICs. I can't quite say.
However... for the HBAs, that's where my root is :O. This is mildly concern=
ing :D.

