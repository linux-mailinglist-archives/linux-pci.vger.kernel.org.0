Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C694620129
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiKGV3G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiKGV3F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:29:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842B9248EA
        for <linux-pci@vger.kernel.org>; Mon,  7 Nov 2022 13:29:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 222B26131F
        for <linux-pci@vger.kernel.org>; Mon,  7 Nov 2022 21:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B60C433C1;
        Mon,  7 Nov 2022 21:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667856543;
        bh=AaqEyQ9mkNaR7cGSpwmK89Wx4gQKx6MqegeLH6GxyJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XkoL54Zz+37lgoAdgTfODkYLze86JsD1EJ7xul+UjswVCitKFNgdxbuQ860w8Akr/
         RRfWzssZxcdAbKZdPehFVP2TrU4qKHQpwgOp4Jrl8X4Ubgm8Pf1ZhOFlZyVeGvneYm
         tnBUShw/PwhUx3WoJaNn3DdnMlS4i/dTUcUAmLHUrMyszV31LKxxr16HCn4wOMrshq
         A4ddr7nGvhrS+CGe48MoPDZlTYVR0nGO3kzWPKiekNyELKsuJRAAJzY+LyOAzTYsW5
         fVkT+gJFoiQpZq0AmJMwyN4P8hjUnGeZ0AUYMtpWuCI9VDL+Hbal1C/9Q7A2tgoNK5
         v781MntTnY+tw==
Date:   Mon, 7 Nov 2022 15:29:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pci@vger.kernel.org
Subject: Re: [External] : Re: sysfs interface to force power off
Message-ID: <20221107212901.GA421901@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0081d0f6-871f-3d07-1af7-0e8e41f5d983@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 07, 2022 at 04:14:54PM -0500, James Puthukattukaran wrote:
> ...

> I have a patch that I've tested out assuming this makes  approach
> makes sense.

Don't hesitate to post the patch.  It's always easier to talk about
things when we can see the concrete details.
