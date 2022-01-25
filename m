Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BC749AF8F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 10:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456501AbiAYJLj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 04:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453785AbiAYIzq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 03:55:46 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04407C07853E
        for <linux-pci@vger.kernel.org>; Mon, 24 Jan 2022 23:49:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u18so46793152edt.6
        for <linux-pci@vger.kernel.org>; Mon, 24 Jan 2022 23:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xxofiFalB9CcXMOf2CSjPnQgVvZYmyKthgmCSSdtGQU=;
        b=PhoOcohGSwuPC5v4CBf9K6MWEIpP+tZVjOT3uPz45p9ky7+sMjMuWNMQl1zuEdt0gi
         HRfVd1b/glsSFQI9lu+wTPdDWLnN2C6a7L2yXezfejJ5gsTtPGnC1V6oR7nrzzwi0ptA
         ysfQKbIK0F67DPQts68CD0ax2ucwVO1zXcKWM1Q1jT7oZLb63lC83T/S8RUIrYvzRWkU
         X+DILkxxyFnS/4pffzqnwvVWvS5MC+CJAsx0BGgCY+FWXBBHmMYcJ5U6DvM9z/RyEYFW
         0kywJ9vGXVSupb5BK7kGV9xASGa76A/KUNtQIHqmZ/EEUSB+M5uN1SFfvb15EiZhrQMq
         wbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xxofiFalB9CcXMOf2CSjPnQgVvZYmyKthgmCSSdtGQU=;
        b=s+R/9rS0f6V0C3Gmw2KLL6IYeV3iE6tWTa/YoIZ00Q2fz/SuLQJyK1DPh3dRMUeDzG
         BPx5bCcmHOBUF4B4NKbkDUhpXnhxKcXrF1EwlNPvk6m7iphhK7rMk/ZhkREpb67uZrLm
         6H2Pry4Ig1mm1WMBrJGMuOh09opKORsvAYk9tq2oESYaXtUiN3YaihaI+nI8Aq5wy3C8
         neM1cxKC3DZfrws3hwI5mKOwZdHcuEB1ixxDhxaWyNhOg/FV+dx1y/EfnDB879c2Zh2p
         ZEonspFGZb7qcJFLx1LK/IrfCnW0bKF5KXJGkN6b46tKAOWxIOZGpYI6BU6nq4pmdPm9
         3fXQ==
X-Gm-Message-State: AOAM5303rnIe8bg3iUO086/kSp6gz54vvG7fMRpdDl4U2G1zd1zvAwn6
        yRWIiZX8qDIFtRkjICEjcTKLJQFfRwaDPOI9W5hKbPbh
X-Google-Smtp-Source: ABdhPJw/KxUebR+SUrFpiVlSrOWbn0uXvnap4eqIz1Yf7nefrY7OHLsZUbcC/gl58T6fKa5ZGNzeEOI6oIDb53tPdu4=
X-Received: by 2002:a50:a40d:: with SMTP id u13mr19558134edb.293.1643096978225;
 Mon, 24 Jan 2022 23:49:38 -0800 (PST)
MIME-Version: 1.0
From:   Manish Raturi <raturi.manish@gmail.com>
Date:   Tue, 25 Jan 2022 13:19:26 +0530
Message-ID: <CAHn-FMyXvr3jNHrDw_rT3DSkH9gecjPse9EGQpgpCkZ2ratCCg@mail.gmail.com>
Subject: Behaviour on AER fatal Error
To:     linux-pci@vger.kernel.org
Cc:     helgaas@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

We are observing a behavior, where if there is a Fatal error on the
downstream port then AER driver is triggering the root port link
reset, I think that is wrong, it should trigger the link reset of that
DS port which reported the fatal error. Is my understanding wrong here
?

Also, there is no DPC enabled in our kernel.

Thanks & Regards
Manish Raturi
