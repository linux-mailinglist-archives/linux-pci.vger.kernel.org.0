Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ADB4BC8E7
	for <lists+linux-pci@lfdr.de>; Sat, 19 Feb 2022 15:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbiBSOj2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Feb 2022 09:39:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241959AbiBSOj1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Feb 2022 09:39:27 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB0710DA
        for <linux-pci@vger.kernel.org>; Sat, 19 Feb 2022 06:39:07 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id r20so8317336ljj.1
        for <linux-pci@vger.kernel.org>; Sat, 19 Feb 2022 06:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=upYG2eyOSbvkGAbtOc7NwWXdWYVoG9nJfB7Jf/oiu0I=;
        b=ksz5V3T7kPOAFQnqrftvY2nCb3GV9+SA/5S36ghc31UfHgYm3yQdeA+7fYV2KZliOh
         fP49l82G0IDbPgRmhmo4v1/TjDLoAQPOYwlPbX1bjQqUoNavybIXgqMknZUjANIU8ic/
         M7YBOZR0UrpDXwMSnpRosrkd4cUS2D5P/h9QVAd7fchsFC8OYEaumSvla3xNDREzJP+V
         VwqugMcVInKqeOCzKJ/luIkBBITwE94h87OKV+z5ZxEd6QT+M2Mnj2FuwR4q7ejzpdrx
         zPQFVsT989ynEnFS/uETJSlttQdWxE3++0iBq0Wxgm7l4NEG/5mJqDVaLq7KQV9pBDhO
         K3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=upYG2eyOSbvkGAbtOc7NwWXdWYVoG9nJfB7Jf/oiu0I=;
        b=zuepl/Xmdp6DLn6NnN3NDHRmCzM50tW3gQ2WfVzistck6rTxv4e5Sx+zAlZDyBU5Ks
         nbcFVmbgHniG3gTBBGaU3nWw6uShpXAs7DIPQIMprBxRLJiA+UGnOwD+1CHX4KZl4N4R
         KhcvfxfQ3PRUFyVrE5TKIt5+EFvUy6zUJokcr+7j7wLVb7QzVT7y7CPWXIQVrUdukfcy
         VcIDE2l2w6G9rA6uqWNLtreHGJDM1cyF+TzmBXDMF4PAZmGaspKsmTJdmxs6WKbD5Hlb
         JP5tdwXvM9AWHfQpzhCd8UEp3TwJHHXjJnU/v4qIQYE9JLrKvXETaEVUhPl6yn4BKgDc
         7ETw==
X-Gm-Message-State: AOAM531Zn2VhiVhjYH5Qc1jUtERqKT7zwQD9aldY2328smn+JuVJ2hvP
        Q3py1UWpUAFiXbWpMsgEc3XtNWT6xGrLIyMao3M=
X-Google-Smtp-Source: ABdhPJzMIq2iQED/0zmgLUi2oglY35cfML9GdSplkvYzBL/fgAsixU+ulPJuXb3GbIdlnIzxHIsmiei4cV66cyLN3ik=
X-Received: by 2002:a2e:b16e:0:b0:244:d368:57e with SMTP id
 a14-20020a2eb16e000000b00244d368057emr8861656ljm.251.1645281546244; Sat, 19
 Feb 2022 06:39:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6512:104a:0:0:0:0 with HTTP; Sat, 19 Feb 2022 06:39:05
 -0800 (PST)
Reply-To: msbelinaya892@gmail.com
From:   msbelinaya <vincentphilip.sec@gmail.com>
Date:   Sat, 19 Feb 2022 14:39:05 +0000
Message-ID: <CAEQrJKuOwfSHLZ-Gq9797tMEz=BpWaxaSu3wp6GFyh1xN0E4Ag@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2KPZgtiv2YUg2LXYr9in2YLYqtmKINmI2KPYudiq2YLYryDYo9mG2YMg2LPYqtmC2KjZhNmG2Yog
2KjZgtmE2Kgg2LfZitioLiDZhNmC2K8g2KrZhSDYrdir2Yog2LnZhNmJINin2YTYp9iq2LXYp9mE
INio2YMNCtmI2YXYudix2YHYqSDZg9mK2YEg2YrZhdmD2YbZhtinINiv2LnZhSDYqNi52LbZhtin
INin2YTYqNi52LYg2KjYtNmD2YQg2KPZgdi22YQuINij2YbYpyDYp9mE2LPZitiv2KkgS29kam92
aSBIZWdib3INCtmF2YYg2KrYsdmD2YrYpyDZiNij2LnZhdmEINmD2YXYr9mK2LEg2YLYs9mFINin
2YTYudmF2YTZitin2Kog2YHZiiDYqNmG2YMgU3RhbmRhcmRCTlAg2KfZhNmF2K3Yr9mI2K8g2YHZ
iiDYqtix2YPZitinLg0K2KPYudiq2YLYryDYo9mGINil2LHYp9iv2Kkg2KfZhNmE2Ycg2KPZhiDY
o9mE2KrZgtmKINio2YMg2KfZhNii2YYuINmE2K/ZiiDZhdit2KfYr9ir2Kkg2KrYrNin2LHZitip
INmF2YfZhdipINij2LHZitivINij2YYNCtij2LTYp9ix2YPZh9inINmF2LnZgyDZiNij2LnYqtmC
2K8g2KPZhtmDINiz2KrZh9iq2YUg2KjZh9inINmE2KPZhtmH2Kcg2YXYsdiq2KjYt9ipINio2KfY
s9mFINi52KfYptmE2KrZgyDZiNiz2KrYs9iq2YHZitivDQrZhdmG2YfYpy4NCg0KINmB2Yog2LnY
p9mFIDIwMDYg2Iwg2YHYqtitINmF2YjYp9i32YYg2YXZhiDYqNmE2K/ZgyDYrdiz2KfYqNmL2Kcg
2LrZitixINmF2YLZitmFINmE2YXYr9ipIDM2INi02YfYsdmL2Kcg2YjZgdmC2YvYpw0K2YTZhNiq
2YLZiNmK2YUg2YTYr9mJINin2YTZhdi12LHZgSDYp9mE2LDZiiDYo9iq2LnYp9mF2YQg2YXYudmH
INio2YLZitmF2KkgONiMNDAw2IwwMDAuMDAg2KzZhtmK2Ycg2KXYs9iq2LHZhNmK2YbZii4NCtmD
2KfZhiDYqtin2LHZitiuINin2YbYqtmH2KfYoSDYtdmE2KfYrdmK2Kkg2KfYqtmB2KfZgtmK2Kkg
2KfZhNil2YrYr9in2Lkg2YfYsNmHINmH2YggMTYg2YrZhtin2YrYsSAyMDA5LiDZhNiz2YjYoQ0K
2KfZhNit2Lgg2Iwg2KrZiNmB2Yog2YHZiiDYstmE2LLYp9mEINmC2KfYqtmEINmB2YogMTIg2YXY
p9mK2YggMjAwOCDZgdmKINiz2YrYqti02YjYp9mGINiMINin2YTYtdmK2YYg2Iwg2YXZhdinDQrY
o9iz2YHYsSDYudmGINmF2YLYqtmEIDY4MDAwINi02K7YtSDYudmE2Ykg2KfZhNij2YLZhCDYo9ir
2YbYp9ihINix2K3ZhNipINi52YXZhC4NCg0K2YTZhSDYqtiz2YXYuSDYpdiv2KfYsdipINin2YTY
qNmG2YMg2KfZhNiw2Yog2KPYqti52KfZhdmEINmF2LnZhyDYqNi52K8g2KjZiNmB2KfYqtmHINiM
INmB2YLYryDYudmE2YXYqiDYqNiw2YTZgyDZhNij2YbZhw0K2YPYp9mGINi12K/ZitmC2Yog2YjZ
g9mG2Kog2YXYr9mK2LEg2K3Ys9in2KjZhyDYudmG2K/ZhdinINiq2YUg2YHYqtitINin2YTYrdiz
2KfYqCDZgtio2YQg2KrYsdmC2YrYqtmKLiDZiNmF2Lkg2LDZhNmDINmK2KcNCtiz2YrYr9mKDQog
2YTZhSDZitiw2YPYsSDYo9mC2LHYqCDYp9mE2KPZgtin2LHYqCAvINin2YTZiNix2KvYqSDYudmG
2K8g2YHYqtitINin2YTYrdiz2KfYqCDYjCDZiNmE2YUg2YrZg9mGINmF2KrYstmI2KzZi9inINij
2Ygg2YTZitizDQrZhNiv2YrZhyDYo9i32YHYp9mELiDYt9mE2KjYqiDZhdmG2Yog2KXYr9in2LHY
qSDYp9mE2KjZhtmDINin2YTYsNmKINij2KrYudin2YXZhCDZhdi52Ycg2KfZhNij2LPYqNmI2Lkg
2KfZhNmF2KfYttmKINil2LnYt9in2KENCtiq2LnZhNmK2YXYp9iqINio2LTYo9mGINmF2Kcg2YrY
rNioINmB2LnZhNmHINio2KPZhdmI2KfZhNmHINil2LDYpyDZg9in2YYg2LPZitiq2YUg2KrYrNiv
2YrYryDYp9mE2LnZgtivLg0KDQrYo9i52YTZhSDYo9mGINmH2LDYpyDYs9mK2K3Yr9irINmI2YTZ
h9iw2Kcg2KfZhNiz2KjYqCDZg9mG2Kog2KPYqNit2Ksg2LnZhiDZiNiz2YrZhNipINmE2YTYqti5
2KfZhdmEINmF2Lkg2KfZhNmF2YjZgtmBINmE2KPZhtmHDQrYudmG2K/ZhdinINmK2LnZhNmFINmF
2K/Zitix2Ygg2KfZhNio2YbZgyDYo9mG2YfZhSDZhdin2KrZiNinINmI2YTZitizINmE2K/ZitmH
2YUg2YjYsdmK2Ksg2Iwg2YHYpdmG2YfZhSDYs9mK2KPYrtiw2YjZhg0K2KfZhNmF2KfZhCDZhNin
2LPYqtiu2K/Yp9mF2YfZhSDYp9mE2LTYrti12Yog2Iwg2YTYsNmE2YMg2YTYpyDYo9mB2LnZhCDZ
hNinINij2LHZitivINij2YYg2YrYrdiv2Ksg2LTZitihINmD2YfYsNinLiDZg9in2YYNCtiw2YTZ
gyDYudmG2K/ZhdinINix2KPZitiqINin2LPZhSDYudin2KbZhNiq2YMg2Iwg2YPZhtiqINiz2LnZ
itiv2YvYpyDZiNij2KjYrdirINin2YTYotmGINi52YYg2KrYudin2YjZhtmDINmE2KrZgtiv2YrZ
hdmDDQrZg9ij2YLYsdioINij2YLYsdio2KfYoSAvINmI2LHZitirINmE2YTYrdiz2KfYqCDYjCDZ
hti42LHZi9inINmE2KPZhiDZhNiv2YrZgyDZhtmB2LMg2KfYs9mFINi52KfYptmE2KrZhyDZiNiz
2YrZgtmI2YUNCtin2YTZhdmC2LEg2KfZhNix2KbZitiz2Yog2YTZhNio2YbZgyDYqNiq2K3YsdmK
2LEg2KfZhNit2LPYp9ioINmE2YMuINmE2Kcg2YrZiNis2K8g2K7Yt9ixLiDYqtiq2YUg2KfZhNmF
2LnYp9mF2YTYqSDYqNmF2YjYrNioDQrYp9iq2YHYp9mC2YrYqSDZhdi02LHZiNi52Kkg2KrYrdmF
2YrZgyDZhdmGINin2YTYp9mG2KrZh9in2YMg2KfZhNmC2KfZhtmI2YbZii4NCg0K2YXZhiDYp9mE
2KPZgdi22YQg2YTZhtinINij2YYg2YbYt9in2YTYqCDYqNin2YTZhdin2YQg2LnZhNmJINij2YYg
2YbYs9mF2K0g2YTZhdiv2YrYsdmKINin2YTYqNmG2YjZgyDYqNij2K7YsNmH2Kcg2Iwg2YHZh9mF
DQrYo9ir2LHZitin2KEg2KjYp9mE2YHYudmELiDYo9mG2Kcg2YTYs9iqINi02K7YtdmL2Kcg2KzY
tNi52YvYpyDZhNiw2Kcg2KPZgtiq2LHYrSDYo9mGINmG2YLYs9mFINin2YTZhdin2YQg2KjYp9mE
2KrYs9in2YjZiiDYjA0KNTAvNTDZqiDYudmE2Ykg2YPZhNinINin2YTYt9ix2YHZitmGLiDYs9iq
2LPYp9i52K/ZhtmKINit2LXYqtmKINmB2Yog2KjYr9ihINi52YXZhNmKINin2YTYrtin2LUg2YjY
p9iz2KrYrtiv2KfZhQ0K2KfZhNi52KfYptiv2KfYqiDZhNmE2KPYudmF2KfZhCDYp9mE2K7Zitix
2YrYqSDYjCDZiNmH2Ygg2YXYpyDZg9in2YYg2K3ZhNmF2YouDQoNCtmF2YYg2YHYttmE2YMg2KPY
udi32YbZiiDYo9mB2YPYp9ix2YMg2K3ZiNmEINin2YLYqtix2KfYrdmKINiMINij2YbYpyDYrdmC
2YvYpyDYqNit2KfYrNipINmE2YXYs9in2LnYr9iq2YPZhSDZgdmKINmH2LDZhw0K2KfZhNi12YHZ
gtipLiDZhNmC2K8g2KfYrtiq2LHYqtmDINmE2KrYs9in2LnYr9mG2Yog2Iwg2YTZitizINio2LnZ
hdmE2Yog2Iwg2YrYpyDYudiy2YrYstiq2Yog2Iwg2YjZhNmD2YYg2KjYp9mE2YTZhyDYo9ix2K/Y
qg0K2KPZhiDYqti52YTZhSDYo9mG2YbZiiDYp9iz2KrYutix2YLYqiDZiNmC2KrZi9inINmE2YTY
tdmE2KfYqSDYqNi02KPZhiDZh9iw2Ycg2KfZhNix2LPYp9mE2Kkg2YLYqNmEINij2YYg2KPYqti1
2YQg2KjZgw0K2YTZhdi02KfYsdmD2KrZgyDYjCDYo9i52LfZhtmKINix2KPZitmDINmI2KPYsdis
2Ygg2KPZhiDYqti52KfZhdmEINmH2LDZhyDYp9mE2YXYudmE2YjZhdin2Kog2KjYp9i52KrYqNin
2LHZh9inIFRPUA0KU0VDUkVULiDYqNi52K8g2KrZhNmC2Yog2KXYrNin2KjYqtmDINiMINit2LXY
sdmK2YvYpyDYudio2LEg2LnZhtmI2KfZhiDYqNix2YrYr9mKINin2YTYpdmE2YPYqtix2YjZhtmK
INin2YTYtNiu2LXZiiDYjA0KbXNiZWxpbmF5YTg5MkBnbWFpbC5jb20NCtmK2YXZhtit2YMg2KrZ
gdin2LXZitmEINin2YTYtdmB2YLYqS4g2YjZhtiz2K7YqSDZhdmGINi02YfYp9iv2Kkg2KXZitiv
2KfYuSDYp9mE2LXZhtiv2YjZgiDZiNmI2KvZitmC2Kkg2KrYo9iz2YrYsyDYp9mE2LTYsdmD2KkN
Ctin2YTYqtmKINij2YbYtNij2Kog2KfZhNi12YbYr9mI2YIuDQrYqNin2LHZgyDYp9mE2YTZhyDZ
gdmKINin2YbYqti42KfYsSDYsdiv2YPZhSDYp9mE2LnYp9is2YQNCtij2LfZitioINin2YTYqtit
2YrYp9iqDQrYp9mE2LPZitiv2KkgS29kam92aSBIZWdib3INCm1zYmVsaW5heWE4OTJAZ21haWwu
Y29tDQo=
