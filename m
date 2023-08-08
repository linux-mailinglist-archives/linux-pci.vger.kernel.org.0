Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BAE774780
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjHHTPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjHHTPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:15:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCBD3C200;
        Tue,  8 Aug 2023 09:38:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80AA62247E;
        Tue,  8 Aug 2023 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691486707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1anG8IJZHp2UOy4q48lcqQRJhQy3OSUMlqLkKSLuNX8=;
        b=AsKxsIU23VnIvXB6MjRIlupIpguZHhh6Uo3483cmq0eQ54rvU7PfooweNoA04ywlxHdN7P
        cjr7MhnRQOLUzE3Rqzan1icRYIUiQS/IrUtR4A+E74NuQowflx/Y+Jsn8nA1WwETxeWbM1
        ZST4X/QT7ijLm5K+qTWSKhRisknEDw4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5658D13451;
        Tue,  8 Aug 2023 09:25:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s1joE/MJ0mSBFwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 08 Aug 2023 09:25:07 +0000
Date:   Tue, 8 Aug 2023 11:25:06 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, terraluna977@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <ku2hdnc2wixu5ygnwvtzbti3ujgkcte7fluvypno2zufnqqzt5@5ip4ndk4ha5l>
References: <20230726123518.2361181-1-imammedo@redhat.com>
 <20230726123518.2361181-2-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="loif23qxzpmsi74g"
Content-Disposition: inline
In-Reply-To: <20230726123518.2361181-2-imammedo@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--loif23qxzpmsi74g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Wed, Jul 26, 2023 at 02:35:18PM +0200, Igor Mammedov <imammedo@redhat.co=
m> wrote:
> The issue was discovered on Dell Inspiron 7352/0W6WV0 laptop with
> following sequence:
>    1. suspend to RAM
>    2. wake up with the same backtrace being observed:
>    3. 2nd suspend to RAM attempt makes laptop freeze

My Dell laptop suffers this since v6.5-rc1.
I've found this thread because of the same call stack triggering the
NULL ptr dereference I captured on my machine.

I applied this patch and resume works as before and I have observed no
issues during typical usage.

I'd be glad if a fix like this makes it into the next -rc.
Feel free to add

Tested-by: Michal Koutn=FD <mkoutny@suse.com>

Thanks for looking into this,
Michal

--loif23qxzpmsi74g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZNIJ4AAKCRAGvrMr/1gc
jpuqAQC6YiooWMYGa8M8En3OudIzKzX9KgLGGk4WGtRNpJOoewD/XP+2J37kJXqr
7MwD+1Fye6AtqSyVCMDokgVsiwqiiwM=
=hxD1
-----END PGP SIGNATURE-----

--loif23qxzpmsi74g--
