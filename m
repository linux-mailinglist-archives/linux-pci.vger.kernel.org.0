Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F9F410466
	for <lists+linux-pci@lfdr.de>; Sat, 18 Sep 2021 08:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbhIRG2d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Sep 2021 02:28:33 -0400
Received: from [118.255.132.200] ([118.255.132.200]:38227 "EHLO kh57hq.top"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhIRG2c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Sep 2021 02:28:32 -0400
X-Greylist: delayed 1204 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Sep 2021 02:28:30 EDT
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=kh57hq.top;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=admin@kh57hq.top;
 bh=TeYJ48ssNMaIJHygFEr//mz2ox4=;
 b=X2Vri2FPyNfB54kcKuo9ggzon1ZAFS+Hm0NXjyPY8+6iXSpVMgllFzHvkpPPS4LClx9bnS1uVmUW
   +43jXyEoYN7B69y90PQ7QfnaN9FHTsy8uLhi4do/+b6EQDiMP6wLUaEwDJxdYEetNBxOJ1e5MkBr
   8VvTmxtOLe3E4PtqexQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=kh57hq.top;
 b=pMujsFAYy2CoJy+9Y4hqN9iipAb53fTjA8eTM2Sd7TR1NFQCECQ3cH7duLPdr7/TSU1lgYDlaCp1
   kT9MasAprWrXUAF7CuYpsTBGIsly061AXcbzQuwd7K894q7Qnkh5LcFFnCn7JxQMFsGAQJz5Oknm
   DGRGwTW7LYP1Fn3+UpY=;
Message-ID: <20210918140552855761@kh57hq.top>
From:   =?utf-8?B?77yl77y077yj44K144O844OT44K544Gu44GK55+l44KJ44Gb?= 
        <admin@kh57hq.top>
To:     <linux-pci@vger.kernel.org>
Subject: =?utf-8?B?RVRD44K144O844OT44K5?=
Date:   Sat, 18 Sep 2021 14:05:45 +0800
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-mailer: Qfuzbov 0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RVRD44K144O844OT44K544KS44GU5Yip55So44Gu44GK5a6i5qeYOg0KDQpFVEPjgrXjg7zjg5Pj
grnjga/nhKHlirnjgavjgarjgorjgb7jgZfjgZ/jgIINCuW8leOBjee2muOBjeOCteODvOODk+OC
ueOCkuOBlOWIqeeUqOOBhOOBn+OBoOOBjeOBn+OBhOWgtOWQiOOBr+OAgeS4i+iomOODquODs+OC
r+OCiOOCiuips+e0sOOCkuOBlOeiuuiqjeOBj+OBoOOBleOBhOOAgg0KDQrkuIvoqJjjga7mjqXn
tprjgYvjgonlgZzmraLljp/lm6DjgpLnorroqo3jgZfjgabjgY/jgaDjgZXjgYQNCg0KaHR0cHM6
Ly9ldGMtbWVpc2FpLmpwLmNvLWluZm8udG9wDQoNCijnm7TmjqXjgqLjgq/jgrvjgrnjgafjgY3j
garjgYTloLTlkIjjga/jgIHmiYvli5Xjgafjg5bjg6njgqbjgrbjgavjgrPjg5Tjg7zjgZfjgabp
lovjgYTjgabjgY/jgaDjgZXjgYQpDQoNCuKAu+OBk+OBruODoeODvOODq+OBr+mAgeS/oeWwgueU
qOOBp+OBmeOAgg0K44CA44GT44Gu44Ki44OJ44Os44K544Gr6YCB5L+h44GE44Gf44Gg44GE44Gm
44KC6L+U5L+h44GE44Gf44GX44GL44Gt44G+44GZ44Gu44Gn44CB44GC44KJ44GL44GY44KB44GU
5LqG5om/6aGY44GE44G+44GZ44CCDQrigLvjgarjgYrjgIHjgZTkuI3mmI7jgarngrnjgavjgaTj
gY3jgb7jgZfjgabjga/jgIHjgYrmiYvmlbDjgafjgZnjgYzjgIENCiAgRVRD44K144O844OT44K5
5LqL5YuZ5bGA44Gr44GK5ZWP44GE5ZCI44KP44Gb44GP44Gg44GV44GE44CCDQoNCuKWoEVUQ+WI
qeeUqOeFp+S8muOCteODvOODk+OCueS6i+WLmeWxgA0K5bm05Lit54Sh5LyR44CAOTowMO+9njE4
OjAwDQrjg4rjg5Pjg4DjgqTjg6Tjg6vjgIAwNTcwLTAxMDEzOQ0K77yI44OK44OT44OA44Kk44Ok
44Or44GM44GU5Yip55So44GE44Gf44Gg44GR44Gq44GE44GK5a6i44GV44G+44CAMDQ1LTc0NC0x
Mzcy77yJDQowNDUtNzQ0LTY2Mw0K


