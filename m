Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A102047B1FC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 18:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhLTRSR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 12:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhLTRSQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 12:18:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C4BC061574
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 09:18:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j18so21587718wrd.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=X0x6xafzfaKKo6FhLsdP1bFkjwM9OW30EUnjqO/dbJxoA0Kgcl/cDZBLJ1FLFJ9APc
         efMK53Q6zdMTCuAJgv+upf8DrM4SdGEbTh6yu5S6h6n7Aq5Uzx6rLrYnNMmCeW6NiC7G
         ZGunziu823PCRaA7EO2AdJlpREv8NQSlFLc8T3v8tRi5z/7fW7BkCTM+aI2L9DfGxsPJ
         nSzFUZPVRwwajo5YK2hXPJ22WObRh59R6ZOUndfYV72/mCWOyXVRA0JhfKA4nxWFXPpR
         JDp8Qkt6aRZlYPV2/f7OyrTCnGwkc61mP9Q7ktuQ/2JD03mQCl0m/ZcT1QQSiFCCyMnn
         VH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=4jaVkA3WXlBk9OcYBg2CxxvTnJFeCqHbjcaxM12PkwXt4qtHqm8oMAh6YrxLoysvt0
         QcDkLovAN2ojGse0kPlzB7FNnvXOdIX+z0jkVLF8h96cKYhfWS675D6CRAJw9FxUvkos
         q8QR/JWrMJ1b0drJrcQWEVa6zWRWwpTrdjrzrv96gxNCLyYRGnbed5fcD+BnwfyPBJ8v
         JMQb4gGW/ep0hXSWgVFeMVy8pfNrNBVDK6AUquY6wh/vL0ZnJD8U5G9Lj3kBBZT+6/HO
         LnJTuRB+HFEKwxDitq+D5NiOVtrfDxYzbqa7ptG3NC9RpSEQ0QWDFFfItEm4ZcEw/N7u
         zG4A==
X-Gm-Message-State: AOAM530Gn48xlpApKtmbDO40LFTlIYX4l/xpOgsg0pxrD+VEIS1yLSKf
        6/upnxSomYJVg2GaWoqx5tY=
X-Google-Smtp-Source: ABdhPJx/b5PCaFwZ8c0QPVy5rC0FKAI29X7SWo9NxyDF+4szBAJ1SA13I4Axe89XMKvyn/BafXPvhA==
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr13914093wrh.470.1640020694738;
        Mon, 20 Dec 2021 09:18:14 -0800 (PST)
Received: from [192.168.9.102] ([129.205.112.56])
        by smtp.gmail.com with ESMTPSA id s207sm16279699wme.2.2021.12.20.09.18.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 20 Dec 2021 09:18:14 -0800 (PST)
Message-ID: <61c0bad6.1c69fb81.a5584.fb0f@mx.google.com>
From:   Margaret Leung KO May-y <richmanjatau@gmail.com>
X-Google-Original-From: Margaret Leung KO May-y
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Mon, 20 Dec 2021 18:18:07 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bin Frau Margaret Leung Ich habe einen Gesch=E4ftsvorschlag f=FCr Sie, erre=
ichen Sie mich unter: la67737777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
