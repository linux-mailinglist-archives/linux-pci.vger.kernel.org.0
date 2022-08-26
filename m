Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E0F5A30E0
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 23:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbiHZVNg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 17:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344709AbiHZVNa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 17:13:30 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7FE58B5
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 14:13:28 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-33da3a391d8so66650337b3.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=m9wcpsESPaJa1VNPZvMRevtD3fO7aWo1DGqnJTjQdjQ=;
        b=dUjSt2JhZeZdIrq00TLEeit/tctmqKHFZoJNmUcTJPtsICUY1GXYNuw95UFOTpn97I
         cxIkQ9LmdB+/msqIAqUuTHXP16BXs+SVOAHEElSa+QPaS2Cul7uUbf5RxcYlxaKVrnXM
         kvp5X2VnPUs8+x5rwYvuB16Sd9EunWQ5Kl9GJ4mtfZQOQi9Kf4q2dsf2FA1T7CRuzu1S
         YkGIPIGYHMPJ9CtGBpbI/ijYQFl6cQ1OG83/2UuMCf7xmiFuzA8eemRTX55YwZWgqYCv
         LSafT6uWkaOixAJ/1kBYZGktOgjux/x6qYD081V0icPUCBRpQPYcpLWA9PLC+JJFyt8i
         5M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=m9wcpsESPaJa1VNPZvMRevtD3fO7aWo1DGqnJTjQdjQ=;
        b=tQKqBqS4cmRS9vm/g1vVm5m/lkznMlDrjxj9VMIRmkcaGzANck0M4s1MqB+mXqBQTP
         sB6MmfdQ8F/omcwLisqfPkiYCOVeDpWC20T+ILEctK+5p9oEKEuHdjDD/o9nwcptwBpp
         AFRaesihUslqToUaLnDUmU2DJ8kiBOU6xGwdps3tL03PdaTJNR1eD9ebBrw+K8tq5wqS
         4ZTWXn8dCPiN9lnlelnqX9mP8I4/iDH5zVtqn00Qmb4wPolU8WtohjKSw77U5gaRf4aR
         pBU8Z8rrZSbXgeF8R7R0NutejWdrvrV6CuGvgI7CHQn4JnwaBYcJgoo6O2lnP5uL4Gln
         WtcQ==
X-Gm-Message-State: ACgBeo2Qo/LJF8f906bedaD/qCZc+QIkOAhM68AP9+4qPBwo9Ru9y29M
        mS0UT+rsWM008HJ8jVSl6vcRD7mdXz6tJHmv7bc=
X-Google-Smtp-Source: AA6agR7CaV/i5zSAdtvBkb/zUqRK0bcQuruE4Usyr0IT/7SKrITF6PjvL6MBfoZ0ajCschigjwys2yUJbuXBYebFiQI=
X-Received: by 2002:a81:5957:0:b0:33d:d04a:40c9 with SMTP id
 n84-20020a815957000000b0033dd04a40c9mr1624804ywb.399.1661548407616; Fri, 26
 Aug 2022 14:13:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:4747:0:0:0:0 with HTTP; Fri, 26 Aug 2022 14:13:27
 -0700 (PDT)
Reply-To: dysonb@legalprivilege.ch
From:   Dyson Butler <acdjude@gmail.com>
Date:   Fri, 26 Aug 2022 22:13:27 +0100
Message-ID: <CAFEsaS+mq8sE2Zkbv51xMmqhSHcRoSrgwUQe6vbD0Fr7NrywWQ@mail.gmail.com>
Subject: We are broker firm in London-UK,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
Good Day

We are broker firm in London-UK, we have direct Provider of BG/SBLC
specifically for Lease, The provider is tested and trusted. We have
been dealing with the company for paste 6 years. Interested
Agent/Lessee should contact us for directives. We also give out a loan
for project funding.

We are one of the leading financial company, we have major's providers
of Fresh Cut BG, SBLC, POF, MTN, Bonds and CDs that are registered
with us and this financial instruments are specifically for lease and
sale, our providers deliver in time and precision as Seth forth in the
agreement. You are at liberty to engage our leased facilities into
trade programs, project financing, Credit line enhancement, Corporate
Loans (Business Start-up Loans or Business Expansion Loans), Equipment
Procurement Loans (industrial equipment, air planes, ships, etc.) And
many more , Our terms and Conditions are reasonable.

DESCRIPTION OF INSTRUMENTS:

1. Instrument: Bank Guarantee (BG)/SBLC (Appendix A)
2. Total Face Value: 10M MIN to 50B MAX USD or Euro
3. Issuing Bank: HSBC, London or Deutsche Bank Frankfurt, UBS or any Top 25 .
4. Age: One Year, One Day
5. Leasing Price: 5+ 2%
6. Sale Price: 38+2%
7. Delivery SWIFT TO SWIFT.
8. Payment: MT103-23
9. Hard Copy: Bonded Courier within 7 banking days.

If you have need for corporate loans, international project funding,
etc. or if you have a client who requires funding for his project or
business, We are also affiliated to lenders who specialises on funding
against financial instrument, such as BG, SBLC, POF or MTN, we fund
100% of the face value of the financial instrument.Enquiries from
agents/ brokers/ intermediaries are also welcomed; Please reply back
if you are interested in any of our service.

Dyson Butler
