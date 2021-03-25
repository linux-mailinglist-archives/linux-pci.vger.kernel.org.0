Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8B349A51
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 20:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCYTdp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 15:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhCYTd2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 15:33:28 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384C6C06174A;
        Thu, 25 Mar 2021 12:33:28 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:58621)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <marius@gnu.org>)
        id 1lPVjN-0003nh-Pj; Thu, 25 Mar 2021 15:33:21 -0400
Received: from host-37-191-226-238.lynet.no ([37.191.226.238]:41772 helo=localhost)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <marius@gnu.org>)
        id 1lPVjL-0005TK-0E; Thu, 25 Mar 2021 15:33:20 -0400
From:   Marius Bakke <marius@gnu.org>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, bhelgaas@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        puranjay12@gmail.com, rui_feng@realsil.com.cn,
        ulf.hansson@linaro.org, vailbhavgupta40@gamail.com
Subject: Sudden poweroffs when idle on ThinkPad x290s since v5.10-rc1
 (bisected to 7c33e3c4c79a)
In-Reply-To: 20200907100731.7722-1-ricky_wu@realtek.com
Date:   Thu, 25 Mar 2021 20:33:16 +0100
Message-ID: <87tuozm3k3.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

After updating to the 5.10 kernel, my laptop will spontaneously poweroff
when idle after some time (between 30 minutes and three days).

I have bisected it down to a rtsx driver update in 7c33e3c4c79a:

commit 7c33e3c4c79ac5def79e7c773e38a7113eb14204
Author: Ricky Wu <ricky_wu@realtek.com>
Date:   Mon Sep 7 18:07:31 2020 +0800

    misc: rtsx: Add power saving functions and fix driving parameter
=20=20=20=20
    v4:
    split power down flow and power saving function to two patch
=20=20=20=20
    v5:
    fix up modified change under the --- line
=20=20=20=20
    Add rts522a L1 sub-state support
    Save more power on rts5227 rts5249 rts525a rts5260
    Fix rts5260 driving parameter
=20=20=20=20
    Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
    Link: https://lore.kernel.org/r/20200907100731.7722-1-ricky_wu@realtek.=
com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/misc/cardreader/rts5227.c  | 112 +++++++++++++++++++++++++++-
 drivers/misc/cardreader/rts5249.c  | 145 +++++++++++++++++++++++++++++++++=
+++-
 drivers/misc/cardreader/rts5260.c  |  28 +++----
 drivers/misc/cardreader/rtsx_pcr.h |  17 +++++
 4 files changed, 283 insertions(+), 19 deletions(-)

(See also <https://bugzilla.kernel.org/show_bug.cgi?id=3D211809>.)

I'm not sure whether this is a driver or hardware problem and am seeking
feedback on how to further debug the issue.

FWIW the problem does not seem to reproduce on an AMD ThinkPad T14 Gen 1
with the same RTS522A PCIe card reader (on stock Arch 5.10.16 kernel).

Thanks & happy hacking,
Marius

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIUEARYKAC0WIQRNTknu3zbaMQ2ddzTocYulkRQQdwUCYFzlfA8cbWFyaXVzQGdu
dS5vcmcACgkQ6HGLpZEUEHf4ngD+LGctGYG2EYdNavgHwhsvYsfyjXRMo6lrr+fO
NCX2074A/3dOuSD880jXBrGi/NymBDhkUGID/X0MwUrzxoYzXwgN
=DJhI
-----END PGP SIGNATURE-----
--=-=-=--
