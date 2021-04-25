Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92136A799
	for <lists+linux-pci@lfdr.de>; Sun, 25 Apr 2021 15:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhDYN4F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Apr 2021 09:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhDYN4F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Apr 2021 09:56:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916F3C061574
        for <linux-pci@vger.kernel.org>; Sun, 25 Apr 2021 06:55:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso3645641wmq.1
        for <linux-pci@vger.kernel.org>; Sun, 25 Apr 2021 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=l0+KhPuA998Z8V+8ORBIdhooETDag/KsWAI/Yqiy3Zo=;
        b=F2J+Pw/7EoTjpK6CKnOBxagAZHV2f15cWxdDyK2lklEruN088/2S3g44rV/+3ojAaW
         NM8bvheixYjDMrO8xuh5gK4eRx2UZz0pB7R/30gOiiggdqw7123eA9+Oi9pmgaYSq1Fc
         N6aaom4AD//xh/Y4blt0uFRnS/sObXTfoJTtA67JCi4PhDNxRy82CMSNNZspmvw6iZSn
         budw721u/SXnzZ8L2fWBZfgukZk/jYDWEi0rnwxc61rDKyXxoPgUSehBifuJ8EN/p2BH
         w0YKF2OnUK/8g1q5cqwtG0rALIadqzzlY4owkL0H1/vMKnHNBZWSg0062ZofTm4SnLtA
         DEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=l0+KhPuA998Z8V+8ORBIdhooETDag/KsWAI/Yqiy3Zo=;
        b=a2+Lg/xi9ZTs6/bwflW4Wt+xvR5UIBFpDDPfGTFS7POKWJR0MCFgR88H1/HeZ+29sr
         XColavJpbYLEhshGqMx0UgkrziNTj/FpZy8Gqm4DiMWCNmMdlVKbQpoQ6HhFHUig8Cd+
         E1OEgPCVTR5OPopYwnT4nvmvFOIQWK9oZGR5PJ55v3bRVJTZVUNYI2zmyo5cC5jg1fIO
         1/MKTZGc5ycPysK4jAm7e4rK2DwxvaX44G1k+XJuNDZ+ydww6c7GCPYhOFjx1Ps8EWBK
         cuWNw7ONGYbr0GyUjI939ffS6NIHFu1sVHYWf8fkmqugNAPvpVYW5NGGhMh51UHvFL3M
         MXeg==
X-Gm-Message-State: AOAM533cS48yU0FLbyriYkcDPZoUGJ1JJsSmTCJGTxr103IXgXSD8ZFo
        2KRt6okXa8fTbNKISniOwD9XMxHlb4mvOico7t8=
X-Google-Smtp-Source: ABdhPJz5ezbYIge5iYrP4SdUA/TiClSkfhc5IZyvrCQrbkdIPx+23rG0DPf83uzcg0EAoC3sJB/VKXqwCdhwqQnU13U=
X-Received: by 2002:a1c:3587:: with SMTP id c129mr14145041wma.80.1619358922143;
 Sun, 25 Apr 2021 06:55:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:a901:0:0:0:0:0 with HTTP; Sun, 25 Apr 2021 06:55:21
 -0700 (PDT)
Reply-To: marvinphillip002@gmail.com
From:   marvin phillip <abraham45688@gmail.com>
Date:   Sun, 25 Apr 2021 13:55:21 +0000
Message-ID: <CAJOTq-yCojLQVg5gY21Vn_RbhhFHgPy0Cz=zmG-j8Eg47wzgFg@mail.gmail.com>
Subject: Hej
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hej, v=C3=A4nligen informeras om att det h=C3=A4r e-postmeddelandet som kom=
 till
din brevl=C3=A5da inte =C3=A4r ett fel utan riktades specifikt till dig f=
=C3=B6r ditt
=C3=B6verv=C3=A4gande. Jag har ett f=C3=B6rslag p=C3=A5 ($ 7.500.000,00) kv=
ar av min
avlidne klient Ingenj=C3=B6r Carlos som b=C3=A4r samma namn med dig, som br=
ukade
arbeta och bodde h=C3=A4r i Lome Togo. Min sena klient och familj var
inblandade i en bilolycka som tog deras liv . Jag kontaktar dig som
anh=C3=B6rig till den avlidne s=C3=A5 att du kan f=C3=A5 pengarna p=C3=A5 f=
ordringar. Vid
ditt snabba svar kommer jag att informera dig om hur detta f=C3=B6rbund
genomf=C3=B6rs. Kontakta mig p=C3=A5 de h=C3=A4r e-postmeddelandena
(marvinphillip002@gmail.com)
