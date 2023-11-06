Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4A77E1A2A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 07:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjKFGTe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 01:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKFGTd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 01:19:33 -0500
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAC5B8
        for <linux-pci@vger.kernel.org>; Sun,  5 Nov 2023 22:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699251569; x=1699510769;
        bh=55sfDxsZO4PfdLhySwE64hXQWYv/aIoszo0K8IU1vYM=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=IE3MNYX9HFtK/mqZMZwf5mqMsu7UDhv3xkGeHcvLuUuH0mQMCz7M5lfPBCS70gDoJ
         /w8PhcmWNAy6YzWsaJCEpUfkLBhhGba0wBX84HhO/YqzlvGBw/4O6vOpymFxshzKCI
         a9RJbbd4JKZx+n6j/N+E33eQv3SAjOyt8UWAmgO5CvpeuxG96arnq2uz9YLzHT6D9f
         8FScyU53qAEoYJ4L51bip7SCuIUvO1KJvAkLjlVNFxi6nfUZijr2PA9xM04qQL+weX
         BdqpfoyMhprodxFyAMq1eRorD67uVw59mbIT4tkXeMmdULyhY7H0b8i6TIrp/3QRjK
         /YRuPAKP0VP2Q==
Date:   Mon, 06 Nov 2023 06:19:23 +0000
To:     "bjorn@helgaas.com" <bjorn@helgaas.com>
From:   Sebastian Manciulea <manciuleas@protonmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: ixgbe driver fails to load due to PCI device probing failure
Message-ID: <VOa9uYkR9REBXPxzK7ORLNV9vsKzEUcdOOkh-ys1C4GjBLc26CUDZmV2MLqSEHBlNOFOPOkPaUcA28Pi9hcNpS-jSA2_Iw6_SNHQureja-I=@protonmail.com>
Feedback-ID: 38625298:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

I have opened a bug report to help with debugging this issue. https://bugzi=
lla.kernel.org/show_bug.cgi?id=3D218107
The full dmesg output is attached there.

Regards,
Sebastian

